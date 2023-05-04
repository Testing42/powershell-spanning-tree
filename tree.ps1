Set-Location 'c:\current\directory'

$rootDir = "C:\heres\the\current]\directory"

# Get the root directory name
$rootDirName = Split-Path -Leaf $rootDir

# Define a function to get the indentation level
function Get-Indentation($depth) {
    $indentation = "    " * $depth
    return $indentation.Replace(" ", "-")
}

# Define a recursive function to list the directories and files
function List-Directories($root, $depth) {
    # Get the indentation
    $indentation = Get-Indentation $depth

    # Get the directories and files
    $items = Get-ChildItem -LiteralPath $root -Force

    # Iterate through the items
    foreach ($item in $items) {
        # Check if the item is a directory
        if ($item.PSIsContainer) {
            # Print the directory name with indentation
            Write-Output "$indentation[DIR]$($item.Name)"

            # Recursively list the subdirectories and files
            List-Directories $item.FullName ($depth + 1)
        }
        else {
            # Print the file name with indentation
            Write-Output "$indentation$($item.Name)"
        }
    }
}

# Call the function to list the directories and files
$output = List-Directories $rootDir 0

# Export the output to a text file in the current directory
$output | Select-Object -Unique | Out-File -FilePath ".\directory_listing.txt"
