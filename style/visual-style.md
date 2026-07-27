# Visual Style

**Content type:** Guidance

This profile defines the preferred visual foundation for project-owned web
pages and other rendered documentation. It is intended to keep related
interfaces recognizable without requiring every project to use the same
layout or component library.

## Color Palette

The default palette is dark and uses deep green surfaces with bright botanical
accents. Use the semantic custom properties instead of repeating color values
in component styles.

```css
:root {
    color-scheme: dark;

    --bg: #07110b;
    --surface: #0c1911;
    --surface-raised: #11231a;
    --surface-active: #173323;

    --line: #234c32;
    --line-strong: #397a50;

    --text: #e5f1e8;
    --text-strong: #ffffff;
    --muted: #91a99a;

    --green-dark: #31804b;
    --green: #69e28e;
    --green-bright: #a2f6b9;

    --amber: #e7b865;
    --amber-bright: #f2cc60;

    --violet: #d987ff;
    --pink: #ff8bc7;
    --blue: #7ec8ff;
    --red: #ef6f6c;
}
```

Use the tokens according to their semantic roles:

- `--bg` is the page or application background.
- `--surface`, `--surface-raised`, and `--surface-active` establish elevation
  and interaction states.
- `--line` and `--line-strong` define separators, borders, and focus-adjacent
  details.
- `--text`, `--text-strong`, and `--muted` establish the content hierarchy.
- The green tokens express primary actions, success, and brand emphasis.
- Amber, violet, pink, blue, and red are secondary accents and status colors.
  Their meaning should remain consistent within an interface.

Do not communicate state through color alone. Pair color with text, an icon, or
another visible cue, and verify text and interactive-control contrast in the
context where each token is used.

## Typography

The preferred type combination is:

- **Space Grotesk** or **Sora** for headings;
- **Inter** for body text and user-interface controls; and
- **JetBrains Mono** for code, identifiers, and tabular technical data.

Projects should use system fallbacks so content remains readable when web fonts
are unavailable:

```css
:root {
    --font-heading: "Space Grotesk", "Sora", system-ui, sans-serif;
    --font-body: "Inter", system-ui, -apple-system, "Segoe UI", sans-serif;
    --font-mono: "JetBrains Mono", "Cascadia Code", "Consolas", monospace;
}

body {
    font-family: var(--font-body);
}

h1,
h2,
h3,
h4,
h5,
h6 {
    font-family: var(--font-heading);
}

code,
kbd,
pre,
samp {
    font-family: var(--font-mono);
}
```

Font suggestions apply when a project can load or package the fonts without
creating an unsuitable external dependency. Documentation and offline tools
may rely entirely on the listed system fallbacks.
