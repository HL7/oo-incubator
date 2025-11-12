# Resource Cleanup Tool - Recent Updates

## Overview
The resource cleanup tool has been enhanced to include all the manual fixes that were applied to successfully get all artifacts showing in the IG artifacts.html page.

## Enhanced Features Added

### 1. StructureDefinition File Naming Fix
- **Issue**: IG Publisher expects `StructureDefinition-*.xml` but files were named `structuredefinition-*.xml` 
- **Fix**: Automatically renames lowercase files to match Transport pattern
- **Method**: `fix_structure_definition_naming()`

### 2. Problematic File Removal
- **Issue**: XHTML header files (`*-examples-header.xml`) cause XML parsing errors
- **Fix**: Automatically removes these files that prevent IG generation
- **Method**: `remove_problematic_files()`

### 3. Notes File Simplification  
- **Issue**: Complex notes files with `<h2>` elements cause Jekyll processing errors
- **Fix**: Replaces complex content with simple placeholder like Transport notes
- **Method**: `simplify_notes_files()`

### 4. Enhanced Sushi Config Updates
- **Issue**: Sushi config needs to reference correct StructureDefinition file names
- **Fix**: Updates additional-resource entries after renaming files
- **Method**: `update_sushi_config_with_naming_fixes()`

## Enhanced Workflow

The new `ResourceCleanupToolEnhanced` class includes all fixes in proper order:

1. **Remove problematic files** (XHTML headers)
2. **Fix StructureDefinition naming** (lowercase to uppercase)
3. **Build resource inventory**
4. **Validate XML files**
5. **Check for duplicate IDs**
6. **Move documentation files** to pagecontent
7. **Simplify notes files** to prevent Jekyll errors
8. **Validate SVG files**
9. **Update specification file**
10. **Update Sushi configuration** with corrected file names

## Usage

The tool now automatically applies all fixes that were manually applied:

```bash
# Non-interactive mode (applies all recent fixes)
python resource-cleanup-tool.py --non-interactive --ig-root . --resources biologicallyderivedproductdispense,devicerequest,deviceusage,inventoryitem,inventoryreport,supplydelivery,supplyrequest,transport

# Interactive mode
python resource-cleanup-tool.py
```

## Key Changes Made

1. **File Naming Standardization**: All StructureDefinition files now follow `StructureDefinition-ResourceName.xml` pattern
2. **Sushi Configuration**: Updated to include all resource directories in `path-resource` and all StructureDefinitions in `additional-resource`
3. **Error Prevention**: Removes files that cause IG generation failures
4. **Jekyll Compatibility**: Simplifies content that causes processing errors

## Result

With these enhancements, the tool can now:
- Successfully process all 8 resource types without errors
- Generate IGs with all artifacts visible in artifacts.html
- Follow the exact pattern that worked for Transport resource
- Prevent common IG generation failures

## Files Updated

- `resource-cleanup-tool.py` - Enhanced with new methods and workflow
- `sushi-config.yaml` - Updated to include all resources with correct naming
- Documentation files - Moved to pagecontent and simplified as needed
- StructureDefinition files - Renamed to standard pattern

The tool now encapsulates all the knowledge gained from manually fixing the IG generation issues.