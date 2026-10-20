import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const GUARD = "DO NOT EDIT/MODIFY ANYTHING";

export default function (pi: ExtensionAPI) {
  pi.on("input", async (event) => {
    const text = event.text;
    if (!text.trimEnd().endsWith("?")) {
      return { action: "continue" } as const;
    }
    // Don't break slash commands or shell escapes.
    const trimmedStart = text.trimStart();
    if (trimmedStart.startsWith("/") || trimmedStart.startsWith("!")) {
      return { action: "continue" } as const;
    }
    // Idempotent: don't append twice.
    if (text.trimEnd().endsWith(GUARD)) {
      return { action: "continue" } as const;
    }
    return {
      action: "transform",
      text: `${text}\n${GUARD}`,
      ...(event.images ? { images: event.images } : {}),
    } as const;
  });
}
