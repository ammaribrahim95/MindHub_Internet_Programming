```markdown
# Design System Specification: The Nocturnal Luminary

## 1. Overview & Creative North Star
The Creative North Star for this design system is **"The Nocturnal Luminary."** 

In a saturated market of generic "Dark Mode" templates, this system seeks to redefine the high-end SaaS aesthetic through a philosophy of bioluminescence and deep-space layering. We are moving away from the "flat box" paradigm and toward a tactile, editorial experience where light doesn't just sit on a surface—it emerges from it.

By leveraging the deep midnight navy of `#0b1229` and puncturing it with sophisticated sage and serene cyan, we create a workspace that feels calm, authoritative, and expensive. We break the template look by using intentional asymmetry in layout, overlapping glass layers, and an aggressive typography scale that prioritizes breathing room over information density.

## 2. Colors & Tonal Architecture
The palette is built on the foundation of the midnight navy `surface`, using accents not just for decoration, but as functional beacons.

### The "No-Line" Rule
To achieve a premium, seamless feel, **1px solid borders are strictly prohibited for sectioning.** Physical boundaries must be defined solely through background color shifts. 
*   Use `surface-container-low` for large secondary sections sitting on the `surface` background.
*   Use `surface-container-highest` for modal-level importance.
*   Transitions between sections should feel like shifts in atmospheric depth rather than mechanical breaks.

### Surface Hierarchy & Nesting
Treat the UI as a physical stack of semi-transparent materials. 
*   **Base:** `surface` (#0b1229)
*   **Level 1 (Subtle Lift):** `surface-container-low` (#141a32)
*   **Level 2 (Active Cards):** `surface-container-high` (#222941)
*   **Level 3 (Interactive/Floating):** `surface-container-highest` (#2d344c)

### The "Glass & Gradient" Rule
Floating elements (modals, dropdowns, sticky navs) should utilize Glassmorphism. Apply a `backdrop-blur` of 12px to 20px over `surface-variant` at 60% opacity. This prevents the UI from feeling "pasted on" and allows the underlying midnight navy to bleed through, maintaining a cohesive color temperature.

### Signature Textures
CTAs and Hero elements should avoid flat fills. Use a subtle linear gradient (135°) transitioning from `primary` (#b4ddd5) to `primary-container` (#99c1b9). This provides a "brushed silk" texture that signals high-end craftsmanship.

## 3. Typography
This design system utilizes a dual-typeface strategy to balance editorial authority with functional clarity.

*   **Display & Headlines (Manrope):** Chosen for its geometric precision and modern "tech-forward" personality. Use `display-lg` (3.5rem) with tighter letter spacing (-0.02em) for hero sections to create a bold, confident statement.
*   **Body & Labels (Inter):** The industry standard for legibility. All functional text, from `body-md` to `label-sm`, uses Inter to ensure high readability against the dark background.

**Editorial Contrast:** Ensure a stark contrast between `headline-lg` and `body-md`. The "luxury" feel comes from the abundance of negative space around large, crisp white headlines.

## 4. Elevation & Depth
In this system, depth is a product of light and layering, never heavy shadows.

*   **The Layering Principle:** Stacking is the primary tool for hierarchy. A `surface-container-lowest` card placed inside a `surface-container-low` container creates a "recessed" look, perfect for data entry or code blocks.
*   **Ambient Shadows:** When an element must float, use an ultra-diffused shadow.
    *   *Blur:* 40px - 60px.
    *   *Color:* Use a 6% opacity version of `on-surface` (#dce1ff). This mimics a soft glow rather than a muddy grey drop shadow.
*   **The "Ghost Border" Fallback:** If accessibility requires a container edge, use the `outline-variant` token at 15% opacity. It should be "felt" rather than "seen."
*   **Geometric Accents:** Utilize the `tertiary` (#ffcd76) and `secondary` (#93cfeb) tokens for small, high-impact geometric icons. These should be treated as "jewelry" for the interface—small, bright, and meticulously placed.

## 5. Components

### Buttons
*   **Primary:** Gradient fill (`primary` to `primary-container`), `on-primary` text, `md` (0.75rem) roundedness. Use `primary-fixed-dim` for hover states with a subtle `primary` outer glow.
*   **Secondary:** Glassmorphism style. `surface-variant` with 40% opacity, `backdrop-blur`, and a "Ghost Border."
*   **Tertiary (Coral):** Use `tertiary-container` for high-alert actions or "Pro" features.

### Input Fields
Avoid the traditional "box." Use `surface-container-highest` with a bottom-only "Ghost Border." On focus, transition the border to `secondary` (#93cfeb) and add a faint 4px outer glow of the same color.

### Cards & Lists
*   **Forbid Dividers:** Do not use lines to separate list items. Use 16px to 24px of vertical white space (Spacing Scale) or alternating tonal shifts between `surface-container-low` and `surface-container-lowest`.
*   **Roundedness:** Standard containers use `lg` (1rem). Small interactive elements (chips) use `full` (9999px).

### Chips
Use `secondary-container` with `on-secondary-container` text for selection. For filter chips, use a simple `outline` treatment to keep the interface light.

## 6. Do's and Don'ts

### Do:
*   **Embrace Asymmetry:** Align text to the left but allow imagery or data visualizations to bleed off the right edge of the grid.
*   **Prioritize Type Scale:** Use `display-md` for empty states to make them feel like intentional design moments rather than "missing content."
*   **Tint Your Shadows:** Always ensure shadows carry a hint of the Midnight Navy or Cyan tones to keep the palette harmonious.

### Don't:
*   **Don't Use Pure White for Everything:** Use `on-surface` (#dce1ff) for primary text and `on-surface-variant` (#c0c8c5) for secondary text to reduce eye strain.
*   **Don't Overuse Coral:** The `tertiary` warm coral (#FFB703) is a high-energy accent. Use it sparingly (max 5% of the screen) for "New" badges or critical CTA highlights.
*   **Don't Use Default Grids:** Avoid the "3-column card row" whenever possible. Try a 2/3 and 1/3 split to create a more bespoke, editorial rhythm.

---
**Director's Final Note:** This design system is about the "quiet confidence" of high-end software. Every pixel must feel intentional. If a component doesn't serve a clear functional or aesthetic purpose, remove it. Let the typography and the depth of the midnight navy do the heavy lifting.```