# Cocos Creator — Version Reference

| Field | Value |
|-------|-------|
| **Engine Version** | Cocos Creator 3.8.5 |
| **Release Date** | November 2024 (official) |
| **Project Pinned** | 2026-04-25 |
| **Last Docs Verified** | 2026-04-25 |
| **LLM Knowledge Cutoff** | May 2025 |

## Knowledge Gap Warning

The LLM's training data likely covers Cocos Creator up to ~3.6. Versions 3.7–3.8
introduced significant changes that the model may NOT know about, including:

- Custom Render Pipeline (CRP) with post-processing framework
- Spine 4.2 runtime integration
- Deferred rendering pipeline (3.8+)
- GPU instancing and GPU-driven rendering improvements
- Asset bundle v2 format changes
- WeChat Mini Game performance optimizations

Always cross-reference this directory before suggesting Cocos Creator API calls.

## Post-Cutoff Version Timeline

| Version | Release | Risk Level | Key Theme |
|---------|---------|------------|-----------|
| 3.7 | ~2023 | LOW | Custom Render Pipeline alpha, rendering refactors |
| 3.8 | Aug 2023 | MEDIUM | CRP stable, deferred rendering, post-processing |
| 3.8.1 | Late 2023 | MEDIUM | Bug fixes, stability improvements |
| 3.8.2 | Early 2024 | MEDIUM | Performance optimizations |
| 3.8.3 | Apr 2024 | MEDIUM | Material upgrades, asset bundle improvements |
| 3.8.5 | Nov 2024 | HIGH | Package size optimization, 2D/3D bundle reduction |
| 3.8.6 | Jan 2025 | HIGH | Continued package size optimization |
| 3.8.7 | Q2 2025 | HIGH | Latest stable (in testing as of Apr 2025) |

## Verified Sources

- Official docs: https://docs.cocos.com/creator/3.8/manual/zh/
- API reference: https://docs.cocos.com/creator/3.8/api/zh/
- Release notes: https://docs.cocos.com/creator/3.8/manual/zh/release-notes/
- GitHub releases: https://github.com/cocos/cocos-engine/releases
- Upgrade guides: https://docs.cocos.com/creator/3.8/manual/zh/release-notes/
