using MindAttic.Ideas.Abstractions;

// Stamp the Abstractions SDK version this Page was built against. The host gates package loads on it
// (and the packer copies it into idea.json). Whole-number SDK — pinned at 1, additive-only.
[assembly: IdeaSdkVersion(Sdk.Version)]
