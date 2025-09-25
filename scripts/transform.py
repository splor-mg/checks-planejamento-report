from frictionless import Package
import re

def transform_resource(source_descriptor: str):

    package = Package(source_descriptor)
    for resource_name in package.resource_names:
        resource = package.get_resource(resource_name)
        table = resource.to_pandas()
        table = table.map(clean_illegal_chars)
        sheet_name = sanitize_sheet_name(resource.name)
        table.to_excel(f"data-results/{package.name}/{resource.name}.xlsx",
            sheet_name=sheet_name,
            index=False
        )

def clean_illegal_chars(s):
    if isinstance(s, str):
        # remove ASCII control chars except \n, \r, \t
        return re.sub(r"[\x00-\x08\x0b-\x0c\x0e-\x1f]", "", s)
    return s

def sanitize_sheet_name(name: str) -> str:
    # Keep max 31 chars, remove forbidden characters: : \ / ? * [ ]
    illegal = r'[:\\/?*\[\]]'
    safe_name = re.sub(illegal, "_", name)
    return safe_name[:31]  # max 31 chars
