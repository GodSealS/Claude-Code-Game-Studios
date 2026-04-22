# Agent Test Spec: wechat-cloudbase-specialist

## Agent Summary / 代理摘要
Domain: WeChat Cloud Base (云开发) serverless backend development, NoSQL database design optimized for query patterns, cloud functions (Node.js) with anti-cheat validation, security rules for data access control, cloud storage management, real-time data synchronization with database.watch(), quota optimization, and compliance with Chinese data regulations.
Does NOT own: Architecture decisions (Cloud Base vs self-hosted, overall backend strategy) — defers to wechat-specialist, gameplay implementation (wechat-minigame-specialist), shader code (wechat-shader-specialist), UI design/implementation (wechat-ui-specialist).
Model tier: DeepSeek-V3.2 (default for implementation specialists).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references WeChat Cloud Base, NoSQL database, cloud functions, security rules, storage management, real-time sync, quota optimization)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is DeepSeek-V3.2 (default for specialists)
- [ ] Agent definition does not claim authority over architecture decisions or other domains
- [ ] Agent references WeChat Cloud Base-specific constraints (quotas, wx.* APIs, environment initialization)

---

## Test Cases / 测试用例

### Case 1: NoSQL database design for common query patterns
**Input:** "Design a database schema for a multiplayer game with player profiles, inventory, and match history."
**Expected behavior:**
- Provides denormalized NoSQL design optimized for Cloud Base:
  ```typescript
  interface PlayerDocument {
    _id: string; // player_${openid}
    openid: string;
    nickname: string;
    level: number;
    inventory: Array<{
      itemId: string;
      count: number;
      lastObtained: Date;
    }>;
    stats: {
      wins: number;
      losses: number;
      totalScore: number;
    };
    // Embedded for fast reads
    recentMatches: Array<{
      matchId: string;
      timestamp: Date;
      result: 'win' | 'loss' | 'draw';
      score: number;
    }>;
  }

  interface MatchDocument {
    _id: string; // match_${timestamp}_${hash}
    players: string[]; // player IDs
    winner: string | null;
    startTime: Date;
    endTime: Date;
    replayUrl: string; // Cloud storage file ID
  }
  ```
- Explains design rationale:
  - Embed `recentMatches` for fast profile display
  - Use composite keys for relationships
  - Reference `MatchDocument` for full history
- Recommends indexes:
  ```typescript
  // In database console or migration script
  db.collection('players').createIndex({ level: -1 });
  db.collection('players').createIndex({ 'stats.totalScore': -1 });
  db.collection('matches').createIndex({ startTime: -1 });
  ```
- Notes Cloud Base quotas: batch operations for bulk writes, consider read/write ratios

### Case 2: Cloud function with anti-cheat validation
**Input:** "Implement a cloud function to submit player scores with anti-cheat protection."
**Expected behavior:**
- Provides complete cloud function implementation:
  ```typescript
  // cloudfunctions/submitScore/index.ts
  const cloud = require('wx-server-sdk');
  cloud.init({ env: cloud.DYNAMIC_CURRENT_ENV });

  interface SubmitScoreEvent {
    score: number;
    levelId: string;
    playTime: number; // seconds
    checksum: string; // client-generated HMAC
  }

  interface CloudResponse {
    code: number;
    message: string;
    data?: any;
  }

  exports.main = async (event: SubmitScoreEvent, context: any): Promise<CloudResponse> => {
    const { score, levelId, playTime, checksum } = event;
    const { OPENID } = cloud.getWXContext();
    const db = cloud.database();
    
    // 1. Verify checksum (shared secret with client)
    const expectedChecksum = calculateChecksum(score, levelId, playTime, process.env.SECRET_KEY);
    if (checksum !== expectedChecksum) {
      return { code: -1, message: 'Invalid checksum' };
    }
    
    // 2. Validate score is reasonable for level
    const levelConfig = await db.collection('levels').doc(levelId).get();
    const maxPossibleScore = levelConfig.data.maxScore;
    if (score > maxPossibleScore * 1.1) { // 10% tolerance
      return { code: -2, message: 'Score exceeds reasonable limit' };
    }
    
    // 3. Validate play time is reasonable
    const minExpectedTime = levelConfig.data.minPlayTime;
    if (playTime < minExpectedTime * 0.5) { // 50% faster than minimum
      return { code: -3, message: 'Play time too short' };
    }
    
    // 4. Rate limiting
    const recentSubmissions = await db.collection('submissions')
      .where({
        _openid: OPENID,
        timestamp: db.command.gt(Date.now() - 60000) // Last minute
      })
      .count();
    
    if (recentSubmissions.total > 5) {
      return { code: -4, message: 'Rate limited' };
    }
    
    // 5. Save verified score
    await db.collection('scores').add({
      data: {
        _openid: OPENID,
        score,
        levelId,
        playTime,
        timestamp: db.serverDate(),
        verified: true
      }
    });
    
    return { code: 0, message: 'Success', data: { rank: 0 } };
  };
  ```
- Includes best practices:
  - Always use `cloud.getWXContext()` for user identity
  - Environment variables for secrets (`process.env.SECRET_KEY`)
  - Structured response format
  - Transactional operations for data consistency

### Case 3: Security rules configuration
**Input:** "Configure security rules for player data (public read, owner write) and leaderboards (public read, cloud function write only)."
**Expected behavior:**
- Provides granular security rules for Cloud Base:
  ```typescript
  // database rules (JSON format)
  {
    "players": {
      "read": true, // Public read for profiles
      "write": "auth != null && doc._openid == auth.openid" // Owner-only write
    },
    "scores": {
      "read": true, // Public read for leaderboards
      "write": false // Only cloud functions can write
    },
    "inventory": {
      "read": "auth != null && doc._openid == auth.openid", // Owner-only read
      "write": "auth != null && doc._openid == auth.openid" // Owner-only write
    },
    "admin_config": {
      "read": "auth != null && auth.openid in ['admin_openid1', 'admin_openid2']",
      "write": false // Read-only for admins
    }
  }
  ```
- Explains rule logic:
  - `auth.openid` from WeChat login context
  - `doc._openid` field in documents
  - Complex conditions for admin access
- Provides storage rules for user-generated content:
  ```typescript
  // storage rules
  {
    "avatars/{openid}.{ext}": {
      "read": true,
      "write": "auth != null && request.resource.startsWith('avatars/' + auth.openid)"
    },
    "screenshots/{matchId}/{openid}.{ext}": {
      "read": true,
      "write": "auth != null && request.resource.startsWith('screenshots/' + auth.openid)"
    }
  }
  ```
- Notes performance: avoid complex rule evaluation on every request

### Case 4: Real-time data synchronization for multiplayer rooms
**Input:** "Implement real-time synchronization for a multiplayer game room so all players see the same game state."
**Expected behavior:**
- Provides real-time synchronization using `database.watch()`:
  ```typescript
  // Client-side room state synchronization
  class RoomSync {
    private watcher: any = null;
    
    startWatching(roomId: string): void {
      const db = wx.cloud.database();
      this.watcher = db.collection('rooms').doc(roomId).watch({
        onChange: (snapshot) => {
          if (snapshot.docs.length > 0) {
            const roomData = snapshot.docs[0];
            this.onRoomUpdate(roomData);
          }
        },
        onError: (err) => {
          console.error('Room watch error:', err);
          this.reconnectWithBackoff(roomId);
        }
      });
    }
    
    private onRoomUpdate(roomData: any): void {
      // Update local game state
      GameState.instance.updateFromRoomData(roomData);
      
      // Visual feedback for changes
      if (roomData.state === 'playing') {
        this.showGameStart();
      }
    }
    
    stopWatching(): void {
      if (this.watcher) {
        this.watcher.close();
        this.watcher = null;
      }
    }
  }
  
  // Server-side room state updates (cloud function)
  async function updateRoomState(roomId: string, newState: any): Promise<void> {
    const db = cloud.database();
    await db.collection('rooms').doc(roomId).update({
      data: newState,
      updatedAt: db.serverDate()
    });
  }
  ```
- Includes best practices:
  - Exponential backoff for reconnection
  - Delta updates to minimize bandwidth
  - Conflict resolution strategies
  - Connection state management
- Notes quota considerations: `watch()` counts as database read operations

### Case 5: Cloud storage management for user-generated content
**Input:** "Handle user avatar uploads with size limits, format validation, and CDN delivery."
**Expected behavior:**
- Provides complete avatar upload/download implementation:
  ```typescript
  class AvatarManager {
    private static MAX_SIZE = 2 * 1024 * 1024; // 2MB
    private static ALLOWED_TYPES = ['image/jpeg', 'image/png', 'image/webp'];
    
    static async uploadAvatar(filePath: string): Promise<string> {
      const { openid } = wx.getStorageSync('userInfo');
      
      // 1. Validate file size
      const fileInfo = await wx.getFileInfo({ filePath });
      if (fileInfo.size > this.MAX_SIZE) {
        throw new Error(`File too large (max ${this.MAX_SIZE/1024/1024}MB)`);
      }
      
      // 2. Validate file type
      const fileType = await this.detectFileType(filePath);
      if (!this.ALLOWED_TYPES.includes(fileType)) {
        throw new Error(`Unsupported file type: ${fileType}`);
      }
      
      // 3. Upload to Cloud Storage
      const cloudPath = `avatars/${openid}_${Date.now()}.${fileType.split('/')[1]}`;
      const uploadResult = await wx.cloud.uploadFile({
        cloudPath,
        filePath,
        success: (res) => {
          console.log('Upload success:', res.fileID);
        },
        fail: (err) => {
          console.error('Upload failed:', err);
        }
      });
      
      // 4. Update user profile with new avatar URL
      const db = wx.cloud.database();
      await db.collection('players').doc(openid).update({
        data: {
          avatarUrl: uploadResult.fileID,
          avatarUpdated: db.serverDate()
        }
      });
      
      return uploadResult.fileID;
    }
    
    static async getAvatarUrl(fileID: string, size: 'thumb' | 'medium' | 'large' = 'medium'): Promise<string> {
      // Get temporary CDN URL with image processing
      const result = await wx.cloud.getTempFileURL({
        fileList: [{
          fileID,
          maxAge: 3600 // 1 hour cache
        }]
      });
      
      const url = result.fileList[0].tempFileURL;
      
      // Add image processing parameters for CDN
      const sizeParams = {
        thumb: '?imageView2/1/w/100/h/100',
        medium: '?imageView2/1/w/200/h/200',
        large: '?imageView2/1/w/400/h/400'
      };
      
      return url + (sizeParams[size] || '');
    }
  }
  ```
- Includes storage optimization:
  - Automatic cleanup of old avatars
  - CDN caching with appropriate TTL
  - Image format conversion (WebP for modern browsers)
- Notes Cloud Base storage quotas and pricing

### Case 6: Quota optimization and cost control
**Input:** "Our database read operations are exceeding free tier limits. How do we optimize?"
**Expected behavior:**
- Provides comprehensive quota optimization strategies:
  1. **Caching strategies:**
     ```typescript
     // Client-side caching with expiration
     class QueryCache {
       private cache = new Map<string, { data: any, expiry: number }>();
       
       async getWithCache(collection: string, query: any, ttl: number = 60000): Promise<any> {
         const cacheKey = JSON.stringify({ collection, query });
         const cached = this.cache.get(cacheKey);
         
         if (cached && Date.now() < cached.expiry) {
           return cached.data;
         }
         
         const db = wx.cloud.database();
         const result = await db.collection(collection).where(query).get();
         
         this.cache.set(cacheKey, {
           data: result.data,
           expiry: Date.now() + ttl
         });
         
         return result.data;
       }
     }
     ```
  2. **Read optimization:**
     - Use `.field()` to select only needed fields
     - Implement pagination with `.limit()` and `.skip()`
     - Use aggregation instead of multiple queries
  3. **Write optimization:**
     - Batch operations with `.add()` for multiple documents
     - Use transactions for related updates
     - Implement debouncing for frequent updates
  4. **Cloud function optimization:**
     - Keep functions stateless for cold start optimization
     - Use connection pooling for database
     - Implement request batching
- Provides Cloud Base quota monitoring:
  ```typescript
  // Monitor usage and alert on thresholds
  async function checkQuotaUsage(): Promise<void> {
    // Use Cloud Base monitoring API or custom logging
    const usage = await wx.cloud.callFunction({
      name: 'getQuotaUsage'
    });
    
    if (usage.data.reads > 40000) { // 80% of 50K free tier
      console.warn('Approaching read quota limit');
      // Implement automatic throttling
    }
  }
  ```
- Recommends upgrade paths for scaling

### Case 7: Version compatibility and API fallbacks
**Input:** "Handle different WeChat versions where some Cloud Base APIs may not be available."
**Expected behavior:**
- Provides version detection and fallback implementation:
  ```typescript
  class CloudBaseCompat {
    private static hasFeature(feature: string): boolean {
      const { version, SDKVersion } = wx.getSystemInfoSync();
      
      // Feature availability matrix
      const featureMatrix = {
        'database.watch': { minVersion: '2.9.0', minSDK: '2.16.0' },
        'storage.uploadFile': { minVersion: '2.2.0', minSDK: '2.0.0' },
        'cloud.callFunction': { minVersion: '2.2.0', minSDK: '2.0.0' }
      };
      
      const requirements = featureMatrix[feature];
      if (!requirements) return true; // Assume available if not specified
      
      return this.compareVersion(version, requirements.minVersion) >= 0 &&
             this.compareVersion(SDKVersion, requirements.minSDK) >= 0;
    }
    
    static async uploadFileWithFallback(filePath: string, cloudPath: string): Promise<string> {
      if (this.hasFeature('storage.uploadFile')) {
        // Use Cloud Base storage
        const result = await wx.cloud.uploadFile({ filePath, cloudPath });
        return result.fileID;
      } else {
        // Fallback to temporary local storage
        const tempFilePath = `${wx.env.USER_DATA_PATH}/temp_${Date.now()}.jpg`;
        await wx.saveFile({ tempFilePath, filePath });
        
        // Store reference in local database
        const db = wx.cloud.database();
        await db.collection('local_files').add({
          data: {
            localPath: tempFilePath,
            cloudPath,
            uploaded: false
          }
        });
        
        // Background sync when API available
        this.queueForLaterSync(tempFilePath, cloudPath);
        
        return `local:${tempFilePath}`;
      }
    }
    
    private static compareVersion(v1: string, v2: string): number {
      const parts1 = v1.split('.').map(Number);
      const parts2 = v2.split('.').map(Number);
      
      for (let i = 0; i < Math.max(parts1.length, parts2.length); i++) {
        const p1 = parts1[i] || 0;
        const p2 = parts2[i] || 0;
        if (p1 !== p2) return p1 - p2;
      }
      return 0;
    }
  }
  ```
- Includes graceful degradation strategies
- Provides user feedback for unsupported features
- Notes backward compatibility requirements for WeChat Mini Games

### Case 8: Error handling and user feedback
**Input:** "Implement comprehensive error handling for network failures, quota limits, and permission errors."
**Expected behavior:**
- Provides structured error handling system:
  ```typescript
  enum CloudBaseErrorCode {
    NETWORK_ERROR = 1001,
    QUOTA_EXCEEDED = 1002,
    PERMISSION_DENIED = 1003,
    VALIDATION_ERROR = 1004,
    RATE_LIMITED = 1005,
    MAINTENANCE = 1006
  }
  
  class CloudBaseError extends Error {
    constructor(
      public code: CloudBaseErrorCode,
      public message: string,
      public retryable: boolean = false,
      public userMessage?: string
    ) {
      super(message);
      this.name = 'CloudBaseError';
    }
    
    static fromWxError(wxError: any): CloudBaseError {
      // Map WeChat error codes to our domain
      const mapping = {
        '网络错误': CloudBaseErrorCode.NETWORK_ERROR,
        '超过频率限制': CloudBaseErrorCode.RATE_LIMITED,
        '无权限': CloudBaseErrorCode.PERMISSION_DENIED
      };
      
      const code = mapping[wxError.errMsg] || CloudBaseErrorCode.NETWORK_ERROR;
      return new CloudBaseError(
        code,
        wxError.errMsg,
        code === CloudBaseErrorCode.NETWORK_ERROR, // Network errors are retryable
        this.getUserFriendlyMessage(code)
      );
    }
    
    private static getUserFriendlyMessage(code: CloudBaseErrorCode): string {
      const messages = {
        [CloudBaseErrorCode.NETWORK_ERROR]: '网络连接失败，请检查网络后重试',
        [CloudBaseErrorCode.QUOTA_EXCEEDED]: '服务暂时不可用，请稍后再试',
        [CloudBaseErrorCode.PERMISSION_DENIED]: '您没有权限执行此操作',
        [CloudBaseErrorCode.VALIDATION_ERROR]: '输入数据有误，请检查后重试',
        [CloudBaseErrorCode.RATE_LIMITED]: '操作过于频繁，请稍后再试',
        [CloudBaseErrorCode.MAINTENANCE]: '服务维护中，请稍后再试'
      };
      return messages[code] || '发生未知错误';
    }
  }
  
  // Error boundary for Cloud Base operations
  async function withErrorHandling<T>(operation: () => Promise<T>, context: string): Promise<T> {
    try {
      return await operation();
    } catch (error) {
      console.error(`[${context}] Cloud Base error:`, error);
      
      const cbError = CloudBaseError.fromWxError(error);
      
      // Show user-friendly message
      wx.showToast({
        title: cbError.userMessage || '操作失败',
        icon: 'none',
        duration: 2000
      });
      
      // Retry logic for retryable errors
      if (cbError.retryable) {
        await new Promise(resolve => setTimeout(resolve, 1000));
        return withErrorHandling(operation, context + '_retry');
      }
      
      // Log to analytics
      wx.reportAnalytics('cloudbase_error', {
        error_code: cbError.code,
        context,
        timestamp: Date.now()
      });
      
      throw cbError;
    }
  }
  ```
- Includes retry strategies with exponential backoff
- Provides user-friendly error messages in Chinese
- Integrates with WeChat analytics for error tracking
- Notes importance of error recovery for user experience

---

## Protocol Compliance / 协议合规

- [ ] Stays within declared domain (Cloud Base development, database design, cloud functions, security rules, storage management)
- [ ] Redirects architecture decisions (Cloud Base vs self-hosted, overall backend strategy) to wechat-specialist
- [ ] Redirects gameplay implementation to wechat-minigame-specialist
- [ ] Redirects shader requests to wechat-shader-specialist
- [ ] Redirects UI requests to wechat-ui-specialist
- [ ] Always validates user identity via `cloud.getWXContext()` in cloud functions
- [ ] Implements anti-cheat validation for all score/currency transactions
- [ ] Enforces security rules for data access control
- [ ] Considers Cloud Base quotas and pricing in all recommendations
- [ ] Provides version compatibility fallbacks for WeChat API differences
- [ ] Includes comprehensive error handling and user feedback

---

## Coverage Notes

- NoSQL database design (Case 1) demonstrates understanding of Cloud Base document model and query optimization
- Anti-cheat cloud function (Case 2) validates server-side validation and security best practices
- Security rules (Case 3) shows granular access control implementation for different data types
- Real-time synchronization (Case 4) covers multiplayer state management with database.watch()
- Cloud storage management (Case 5) handles user-generated content with validation and optimization
- Quota optimization (Case 6) addresses cost control and performance scaling concerns
- Version compatibility (Case 7) ensures graceful degradation across WeChat versions
- Error handling (Case 8) provides comprehensive user experience for failure scenarios

<!-- 中文翻译标记 / Chinese translation marker -->
