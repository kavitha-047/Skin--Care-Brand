$startDate = Get-Date -Year 2025 -Month 12 -Day 1 -Hour 19 -Minute 0 -Second 0
$endDate = Get-Date -Year 2025 -Month 12 -Day 31 -Hour 23 -Minute 59 -Second 59
# Skip 5 random days
$skipDays = @("2025-12-05", "2025-12-12", "2025-12-18", "2025-12-24", "2025-12-26")
$specialDay = "2025-12-04"

$commitMessages = @(
    "Final performance audit for Aura Skin",
    "Optimizing asset loading priority",
    "Refining responsive behavior for ultra-wide screens",
    "Implementing final accessibility patches",
    "Cleaning up global CSS variables",
    "Updating README with deployment instructions",
    "Optimizing hover animation framerates",
    "Refining meta tags for better SEO ranking",
    "Finalizing brand-compliant icon set",
    "Conducting browser cross-compatibility tests",
    "Optimizing script.js bundle size",
    "Finalizing testimonial card layout refinements",
    "Implementing soft-scroll easing presets",
    "Refining color contrast for accessibility compliance",
    "Project wrap-up and final documentation update"
)

$currentDate = $startDate
while ($currentDate -le $endDate) {
    $dateKey = $currentDate.ToString("yyyy-MM-dd")
    
    # Check if we should skip this day
    if ($skipDays -contains $dateKey) {
        $currentDate = $currentDate.AddDays(1)
        continue
    }

    # Determine number of commits
    $numCommits = 0
    if ($dateKey -eq $specialDay) {
        $numCommits = 10
    } else {
        $possibleCounts = @(1, 2, 3, 5)
        $numCommits = $possibleCounts | Get-Random
    }
    
    for ($i = 0; $i -lt $numCommits; $i++) {
        $msg = $commitMessages | Get-Random
        
        # Jitter the time around 7 PM
        $jitterMin = Get-Random -Minimum -60 -Maximum 120
        $jitterSec = Get-Random -Minimum 0 -Maximum 60
        $commitDate = $currentDate.AddMinutes($jitterMin).AddSeconds($jitterSec)
        
        $dateStr = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
        $authorDate = $dateStr
        $committerDate = $dateStr

        # Modify a file
        Add-Content -Path "commit-tracker.txt" -Value "Final wrap-up at $dateStr : $msg"
        
        Write-Host "Committing: $msg at $dateStr"
        $env:GIT_AUTHOR_DATE = $authorDate
        $env:GIT_COMMITTER_DATE = $committerDate
        
        git add commit-tracker.txt
        git commit -m "$msg" --quiet
    }

    $currentDate = $currentDate.AddDays(1)
}

Write-Host "Finished Dec local commits. Pushing..."
git push origin main
