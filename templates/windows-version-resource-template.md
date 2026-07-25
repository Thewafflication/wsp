# Template — Windows EXE/DLL Version Resource

**Content type:** Template

This template illustrates a generated or configured `.rc` file. Replace the
`WSP_*` macros through a controlled build configuration. Do not release the
placeholder values shown below.

```rc
#include <winver.h>

#define WSP_FILE_VERSION_NUM     1,0,0,0
#define WSP_PRODUCT_VERSION_NUM  1,0,0,0
#define WSP_FILE_VERSION_STR     "1.0.0"
#define WSP_PRODUCT_VERSION_STR  "1.0.0"
#define WSP_FILE_TYPE            VFT_APP
#define WSP_FILE_FLAGS           0x0L

VS_VERSION_INFO VERSIONINFO
 FILEVERSION WSP_FILE_VERSION_NUM
 PRODUCTVERSION WSP_PRODUCT_VERSION_NUM
 FILEFLAGSMASK VS_FFI_FILEFLAGSMASK
 FILEFLAGS WSP_FILE_FLAGS
 FILEOS VOS_NT_WINDOWS32
 FILETYPE WSP_FILE_TYPE
 FILESUBTYPE VFT2_UNKNOWN
BEGIN
  BLOCK "StringFileInfo"
  BEGIN
    BLOCK "040904B0"
    BEGIN
      VALUE "CompanyName", "Company name"
      VALUE "FileDescription", "Program or module description"
      VALUE "FileVersion", WSP_FILE_VERSION_STR
      VALUE "InternalName", "module-name"
      VALUE "LegalCopyright", "Copyright notice"
      VALUE "OriginalFilename", "program.exe"
      VALUE "ProductName", "Product name"
      VALUE "ProductVersion", WSP_PRODUCT_VERSION_STR
      VALUE "Comments", "https://github.com/owner/project"
    END
  END
  BLOCK "VarFileInfo"
  BEGIN
    VALUE "Translation", 0x0409, 1200
  END
END
```

For a DLL, set `WSP_FILE_TYPE` to `VFT_DLL`, use the DLL module name for
`InternalName`, and use the exact `.dll` output name for `OriginalFilename`.

For debug or prerelease builds, derive `WSP_FILE_FLAGS` from the controlled
configuration and version identity. Add `PrivateBuild` or `SpecialBuild` only
when the corresponding flag is set.
