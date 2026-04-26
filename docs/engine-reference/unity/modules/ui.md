# Unity 6.3 — UI Module Reference / UnityUI模块


> **中文翻译**：本文档为Unity引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Knowledge Gap:** Unity 6 UI Toolkit is production-ready for runtime UI

---

<!-- 概述 -->
## Overview

Unity 6 UI systems:
- **UI Toolkit** (RECOMMENDED): Modern, performant, HTML/CSS-like (production-ready in Unity 6)
- **UGUI (Canvas)**: Legacy system, still supported but not recommended for new projects
- **IMGUI**: Editor-only, deprecated for runtime UI

---

<!-- 中文翻译 -->
## UI Toolkit (Modern UI)

<!-- 中文翻译 -->
### Setup UI Document

1. Create UXML (UI structure):
   - `Assets > Create > UI Toolkit > UI Document`
2. Create USS (styling):
   - `Assets > Create > UI Toolkit > StyleSheet`
3. Add to scene:
   - `GameObject > UI Toolkit > UI Document`
   - Assign UXML to `UIDocument > Source Asset`

---

<!-- 中文翻译 -->
### UXML (UI Structure)

```xml
<!-- MainMenu.uxml -->
<ui:UXML xmlns:ui="UnityEngine.UIElements">
    <ui:VisualElement class="container">
        <ui:Label text="Main Menu" class="title" />
        <ui:Button name="play-button" text="Play" />
        <ui:Button name="settings-button" text="Settings" />
        <ui:Button name="quit-button" text="Quit" />
    </ui:VisualElement>
</ui:UXML>
```

---

<!-- 中文翻译 -->
### USS (Styling)

```css
/* MainMenu.uss */
.container {
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
    background-color: rgb(30, 30, 30);
}

.title {
    font-size: 48px;
    color: white;
    margin-bottom: 20px;
}

Button {
    width: 200px;
    height: 50px;
    margin: 10px;
    font-size: 24px;
}

Button:hover {
    background-color: rgb(100, 150, 200);
}
```

---

<!-- 中文翻译 -->
### C# Scripting (UI Toolkit)

```csharp
using UnityEngine;
using UnityEngine.UIElements;

public class MainMenu : MonoBehaviour {
    void OnEnable() {
        var root = GetComponent<UIDocument>().rootVisualElement;

        // Query elements by name
        var playButton = root.Q<Button>("play-button");
        var settingsButton = root.Q<Button>("settings-button");
        var quitButton = root.Q<Button>("quit-button");

        // Register callbacks
        playButton.clicked += OnPlayClicked;
        settingsButton.clicked += OnSettingsClicked;
        quitButton.clicked += Application.Quit;
    }

    void OnPlayClicked() {
        Debug.Log("Play clicked");
        // Load game scene
    }

    void OnSettingsClicked() {
        Debug.Log("Settings clicked");
        // Open settings menu
    }
}
```

---

<!-- 中文翻译 -->
### Common UI Elements

```csharp
// Label (text display)
var label = root.Q<Label>("score-label");
label.text = "Score: 100";

// Button
var button = root.Q<Button>("submit-button");
button.clicked += OnSubmit;

// TextField (text input)
var textField = root.Q<TextField>("name-input");
string playerName = textField.value;

// Toggle (checkbox)
var toggle = root.Q<Toggle>("music-toggle");
bool isMusicEnabled = toggle.value;

// Slider
var slider = root.Q<Slider>("volume-slider");
float volume = slider.value; // 0-1

// DropdownField (dropdown menu)
var dropdown = root.Q<DropdownField>("difficulty-dropdown");
dropdown.choices = new List<string> { "Easy", "Normal", "Hard" };
dropdown.value = "Normal";
```

---

<!-- 中文翻译 -->
### Dynamic UI Creation (No UXML)

```csharp
void CreateUI() {
    var root = GetComponent<UIDocument>().rootVisualElement;

    // Create elements
    var container = new VisualElement();
    container.AddToClassList("container");

    var label = new Label("Hello, UI Toolkit!");
    var button = new Button(() => Debug.Log("Clicked")) { text = "Click Me" };

    container.Add(label);
    container.Add(button);
    root.Add(container);
}
```

---

<!-- 中文翻译 -->
### USS Flexbox Layout

```css
/* Horizontal layout */
.horizontal {
    flex-direction: row;
}

/* Vertical layout (default) */
.vertical {
    flex-direction: column;
}

/* Center children */
.centered {
    align-items: center;
    justify-content: center;
}

/* Spacing */
.spaced {
    justify-content: space-between;
}
```

---

<!-- 中文翻译 -->
## UGUI (Legacy Canvas UI)

<!-- 中文翻译 -->
### Basic Setup (Still Works in Unity 6)

```csharp
// GameObject > UI > Canvas (creates Canvas, EventSystem)

// UI Elements:
// - Text (use TextMeshPro instead)
// - Button
// - Image
// - Slider
// - Toggle
// - InputField
```

---

<!-- 中文翻译 -->
### UGUI Scripting

```csharp
using UnityEngine;
using UnityEngine.UI;
using TMPro; // TextMeshPro

public class LegacyUI : MonoBehaviour {
    public TextMeshProUGUI scoreText;
    public Button playButton;
    public Slider volumeSlider;

    void Start() {
        // Update text
        scoreText.text = "Score: 100";

        // Button click
        playButton.onClick.AddListener(OnPlayClicked);

        // Slider value changed
        volumeSlider.onValueChanged.AddListener(OnVolumeChanged);
    }

    void OnPlayClicked() {
        Debug.Log("Play clicked");
    }

    void OnVolumeChanged(float value) {
        AudioListener.volume = value;
    }
}
```

---

<!-- 中文翻译 -->
### TextMeshPro (Better Text Rendering)

```csharp
// Install: Window > TextMeshPro > Import TMP Essential Resources

// Use TMP_Text instead of Unity's Text component
using TMPro;

public TextMeshProUGUI tmpText;
tmpText.text = "High Quality Text";
tmpText.fontSize = 24;
tmpText.color = Color.white;
```

---

<!-- 中文翻译 -->
## Canvas Settings (UGUI)

<!-- 中文翻译 -->
### Render Modes

```csharp
// Screen Space - Overlay: UI rendered on top of everything (no camera needed)
// Screen Space - Camera: UI rendered by specific camera (allows effects)
// World Space: UI in 3D world (e.g., floating health bars)
```

<!-- 中文翻译 -->
### Canvas Scaler (Responsive UI)

```csharp
// UI Scale Mode:
// - Constant Pixel Size: UI elements have fixed pixel size
// - Scale With Screen Size: UI scales based on reference resolution (RECOMMENDED)
// - Constant Physical Size: UI elements have fixed physical size (cm)

// Example: Scale With Screen Size
// Reference Resolution: 1920x1080
// Screen Match Mode: Match Width Or Height (0.5 = balanced)
```

---

<!-- 中文翻译 -->
## Layout Groups (UGUI)

<!-- 中文翻译 -->
### Horizontal Layout Group

```csharp
// Auto-arranges children horizontally
// Add: GameObject > Add Component > Horizontal Layout Group
```

<!-- 中文翻译 -->
### Vertical Layout Group

```csharp
// Auto-arranges children vertically
```

<!-- 中文翻译 -->
### Grid Layout Group

```csharp
// Arranges children in a grid
```

---

<!-- 中文翻译 -->
## Performance (UI Toolkit vs UGUI)

<!-- 中文翻译 -->
### UI Toolkit Advantages
- ✅ Faster rendering (retained mode)
- ✅ Better for complex UIs with many elements
- ✅ Easier styling (CSS-like)
- ✅ Better for dynamic UIs

<!-- 中文翻译 -->
### UGUI Advantages
- ✅ More mature, widely documented
- ✅ Better integration with Unity Editor
- ✅ Easier for beginners

---

<!-- 常见模式 -->
## Common Patterns

<!-- 中文翻译 -->
### Health Bar (UI Toolkit)

```csharp
var healthBar = root.Q<VisualElement>("health-bar");
healthBar.style.width = new StyleLength(new Length(healthPercent, LengthUnit.Percent));
```

<!-- 中文翻译 -->
### Health Bar (UGUI)

```csharp
public Image healthBarImage;

void UpdateHealth(float percent) {
    healthBarImage.fillAmount = percent; // 0-1
}
```

---

<!-- 中文翻译 -->
### Fade In/Out (UI Toolkit)

```csharp
IEnumerator FadeIn(VisualElement element, float duration) {
    float elapsed = 0f;
    while (elapsed < duration) {
        elapsed += Time.deltaTime;
        element.style.opacity = Mathf.Lerp(0f, 1f, elapsed / duration);
        yield return null;
    }
}
```

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### UI Toolkit Debugger
- `Window > UI Toolkit > Debugger`
- Inspect element hierarchy, styles, layout

<!-- 中文翻译 -->
### UGUI Event System Debugger
- Select EventSystem in Hierarchy
- Inspector shows active input module, raycast info

---

<!-- 来源 -->
## Sources
- https://docs.unity3d.com/6000.0/Documentation/Manual/UIElements.html
- https://docs.unity3d.com/Packages/com.unity.ui@2.0/manual/index.html
- https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/index.html
