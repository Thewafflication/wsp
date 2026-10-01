# Structured Source Documentation

**Content type:** Requirements guidance and examples

This guide implements WSP-STYLE-0006 across language profiles. Existing
WSP-CSTYLE requirements remain binding for C. Doxygen-style contracts describe
intent and observable behavior, not merely names or implementation steps.
Comments and documentation examples obey the same physical line ceiling.

## Contract Fields

For files/modules, describe purpose, ownership, exported interfaces, and
important dependencies. For callable interfaces, document each input, units,
valid ranges, return/result, ownership/lifetime, errors/exceptions, side effects,
thread/cancellation behavior, and preconditions/postconditions where relevant.
Use `@file`, `@brief`, `@param`, `@tparam`, `@return`, `@retval`, `@throws`,
`@pre`, `@post`, and `@note` when meaningful. State not-applicable attributes
where omitting them would leave an ambiguous contract; do not invent an error
or return value for an interface that has none.

Document public types, macros/constants, properties, and members; explain
non-obvious internal behavior and compatibility workarounds near the code.
Use `@copydoc`/references for a shared declaration/definition contract so the
text does not drift. Review documentation alongside behavior changes.

## C and C++ Example

```cpp
/** @file parser.hpp
 *  @brief Parse unsigned decimal configuration values.
 */

/** @brief Parse an unsigned decimal value.
 *  @param text Non-null, NUL-terminated ASCII decimal input.
 *  @param result Receives the value only on success; caller-owned.
 *  @return True on success; false for malformed or overflowing input.
 *  @pre result is non-null.
 *  @post A false result leaves *result unchanged.
 *  @note Does not retain pointers or perform I/O.
 */
bool parse_unsigned(const char *text, unsigned *result);
```

Use Doxygen special blocks, `///` blocks, or documented member forms such as
`///<`. Require the language parser to discover the actual API; searching for
the string `@param` alone is not documentation coverage validation.

## Python Example

Doxygen recognizes special `##` comments and its documented Python docstring
forms. Keep runtime `__doc__` useful; a project may use a native docstring
convention with a tested Doxygen adapter instead of duplicating contracts.

```python
## @file values.py
# @brief Validate numeric configuration.

## @brief Validate a positive retry count.
# @param value Integer count; booleans are rejected.
# @return The validated integer without modification.
# @throws ValueError If value is not a positive integer.
def retry_count(value: int) -> int:
    """Validate a positive retry count; raise ValueError otherwise."""
    if isinstance(value, bool) or not isinstance(value, int) or value <= 0:
        raise ValueError("retry count must be a positive integer")
    return value
```

## C# and VB.NET Examples

Native XML comments preserve IDE/compiler documentation. Include or translate
these contracts in the generated API reference. C# is supported by Doxygen;
verify XML-tag extraction with the selected version/configuration. VB.NET
requires a tested adapter or native XML-doc generator, not a claimed native
Doxygen parser.

```csharp
/// <summary>Return the validated positive retry count.</summary>
/// <param name="value">Retry count supplied by the caller.</param>
/// <returns>The unchanged positive count.</returns>
/// <exception cref="ArgumentOutOfRangeException">
/// The count is zero or negative.
/// </exception>
public static int RetryCount(int value)
{
    if (value <= 0)
    {
        throw new ArgumentOutOfRangeException(nameof(value));
    }
    return value;
}
```

```vb
''' <summary>Return the validated positive retry count.</summary>
''' <param name="value">Retry count supplied by the caller.</param>
''' <returns>The unchanged positive count.</returns>
''' <exception cref="ArgumentOutOfRangeException">
''' The count is zero or negative.
''' </exception>
Public Function RetryCount(value As Integer) As Integer
    If value <= 0 Then
        Throw New ArgumentOutOfRangeException(NameOf(value))
    End If
    Return value
End Function
```

## PowerShell Example

Use native comment-based help, with a controlled adapter when publishing
Doxygen output. `.SYNOPSIS` maps to brief purpose, `.PARAMETER` to parameter
contracts, `.OUTPUTS` to results, and `.NOTES` to errors/side effects. Do not
replace `Get-Help` support with unrecognized C-style syntax.

```powershell
<#
.SYNOPSIS
Validates a positive retry count.
.PARAMETER Value
An integer greater than zero; caller-owned configuration data.
.OUTPUTS
System.Int32. The unchanged positive count.
.NOTES
Throws for zero/negative counts. Performs no I/O or persistent mutation.
#>
function Get-RetryCount {
    [CmdletBinding()]
    param([Parameter(Mandatory)][int]$Value)
    if ($Value -le 0) {
        throw 'Retry count must be positive.'
    }
    return $Value
}
```

## YAML, Make, CMake, and Strict JSON

Where `#` comments are legal, use a documented Doxygen-style convention:

```yaml
# @file retry-policy.yaml
# @brief Retry policy for transient transport errors.
# @param attempts Maximum attempts, including the initial request; 1..5.
# @note Does not retry permanent authentication errors.
attempts: 3
```

Make/CMake comments should document public targets/functions, inputs, outputs,
and side effects similarly. Doxygen does not natively parse these formats or
PowerShell; a project must provide a controlled, tested filter/adapter or
publish the reference as a Doxygen page. Merely using `# @brief` does not
prove successful extraction.

Strict JSON has no comments. Keep its schema/descriptions and an adjacent
reference synchronized with the configuration. For example:

```json
{
  "attempts": 3
}
```

```text
@page retry_policy Retry Policy
Configuration file: retry-policy.json
attempts: integer, 1..5, including the initial request.
Default: 3. Permanent authentication errors are never retried.
```

Save the page block inside a valid Doxygen `/** ... */` comment in a `.dox`
file and include it in documentation inputs. A native schema may use its
legal `description` fields; do not add undocumented data keys to production
configuration just to simulate comments.

## Documentation Gate

Configure owned file patterns, include paths, preprocessing symbols, static
entities, and adapters explicitly. Use warnings-as-errors, undocumented-entity
warnings, documentation-error warnings, and parameter-documentation warnings
as applicable. Doxygen's `EXTRACT_ALL=YES` can disable missing-documentation
warnings; use a strict owned-source configuration and review coverage.

For unsupported languages, test the adapter with a documented and an
undocumented public entity; extraction or adapter failures must block the
required gate. Compare generated entity inventories with owned public APIs.
Check language-native help/XML/schema output as well. None of these tools
can decide whether a contract is truthful; retain human review.

References: [Doxygen blocks](https://www.doxygen.nl/manual/docblocks.html),
[Doxygen filters/configuration](https://www.doxygen.nl/manual/config.html),
[PowerShell help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help),
and [C# XML docs](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/).
