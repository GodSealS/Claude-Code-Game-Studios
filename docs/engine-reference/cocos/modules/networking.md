# Cocos Creator — Networking Module

Last verified: 2026-04-25

## Core Types

| Type | Purpose |
|------|---------|
| `WebSocket` | Browser/mini game WebSocket client |
| `XMLHttpRequest` / `fetch` | HTTP requests |
| `socket.io` (3rd party) | Common choice for multiplayer |

## WebSocket Example

```typescript
const ws = new WebSocket('wss://game.example.com/ws');

ws.onopen = () => {
    ws.send(JSON.stringify({ type: 'join', roomId: 'room_1' }));
};

ws.onmessage = (event) => {
    const data = JSON.parse(event.data);
    this.handleServerMessage(data);
};

ws.onclose = () => {
    // Implement reconnection logic
};
```

## HTTP with fetch

```typescript
async loadPlayerData(playerId: string): Promise<PlayerData> {
    const response = await fetch(`${this.apiBase}/players/${playerId}`);
    if (!response.ok) throw new Error('Failed to load');
    return await response.json();
}
```

## WeChat Mini Game

Use `wx.request()` instead of `fetch` for better compatibility:
```typescript
wx.request({
    url: 'https://api.example.com/score',
    method: 'POST',
    data: { score: 100 },
    success: (res) => { /* handle */ }
});
```

## Pitfalls

- WRONG: Sending game state every frame over WebSocket
- RIGHT: Send at fixed rate (e.g., 10-20Hz); interpolate locally
- WRONG: Trusting client-side data in authoritative server games
- RIGHT: Server validates all inputs
