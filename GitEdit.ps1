Function git-EditConfig ( [boolean] $cmd = $false )
{
    $gitConfig = "c:\Users\$($env:Username)\.gitconfig"

    if ( $true -eq $cmd )
    {
        git config --global --edit
    }
    else 
    {
        notepad $gitConfig
    }
    
    return ".gitconfig location: [$gitConfig]"
}
