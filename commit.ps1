#commit current_branch new_branch

#check for correct number of args
$argCount = $args.Count
$abort = $false
$testing = $false

$incorrectArgCount = $argCount -ne 2

Write-Host $argCount

if($incorrectArgCount){
    Write-Host "commit requires 2 parameters, old_branch and new_branch"
    Write-Host "example 1: commit P01 P02"
    Write-Host "example 2: commit 2021-04-10-P07 P01"
    Write-Host "example 2: commit 2021-04-10-P07 2021-04-11-P01"
    $abort = $true
}

$old_branch = $args[0].ToString()
$new_branch = $args[1].ToString()


if(-not ($old_branch.Length -eq 3) -xor ($old_branch.Length -eq 14)){
    Write-Host "parameter 1 ( $old_branch ) must be of length 3 or 14 [PO7] or [2021-04-17-P07]"
    $abort = $true
}

if(-not ($new_branch.Length -eq 3) -xor ($new_branch.Length -eq 14)){
    Write-Host "parameter 2 ( $new_branch ) must be of length 3 or 14 [PO7] or [2021-04-17-P07]"
    $abort = $true
}


if (-not $abort){
    $dateToday = Get-Date -Format yyyy-MM-dd
    $stem = $dateToday.ToString() + "-"


    if($old_branch.Length -eq 3){ $old_branch = $stem + $old_branch }
    if($new_branch.Length -eq 3){ $new_branch = $stem + $new_branch }

    #$old_branch = $stem + $args[0]
    #$new_branch = $stem + $args[1]

    if($testing){
    Write-Host "git status"
    Write-Host "git add ."
    Write-Host "git commit -m "automated commit""
    Write-Host "git push"
    Write-Host "git checkout main"
    Write-Host "git merge $old_branch"
    Write-Host "git push"
    Write-Host "git checkout -b $new_branch"
    Write-Host "git push -u origin $new_branch"
    Write-Host "git status"
    } else {
        git status
        git add .
        git commit -m "automated commit"
        git push
        git checkout main
        git merge $old_branch
        git push
        git checkout -b $new_branch
        git push -u origin $new_branch
        git status
    }

    # TODO have progarm detect the date
    # TODO change program to accept P01 and P02 as the parameters
    # TODO $date (format 2021-04-17) + "-" + P02
}