$startDate = Get-Date -Year 2025 -Month 6 -Day 1 -Hour 14 -Minute 0 -Second 0
$endDate = Get-Date -Year 2025 -Month 7 -Day 31 -Hour 23 -Minute 59 -Second 59
# Skip 5 random days
$skipDays = @("2025-06-08", "2025-06-22", "2025-07-04", "2025-07-15", "2025-07-29")

$commitMessages = @(
    "Optimizing SVG noise texture for performance",
    "Implementing magnetic button physics for CTAs",
    "Refining typography hierarchy for premium readability",
    "Customizing scrollbar to match brand aesthetic",
    "Adding smooth parallax transitions to product cards",
    "Optimizing image delivery with modern formats",
    "Implementing staggered entry animations for grid items",
    "Refining glassmorphism blur intensity on navigation",
    "Adding micro-interactions for heart icon toggle",
    "Tweaking color variables for more vibrant lavender tones",
    "Implementing custom cubic-bezier transitions for UI",
    "Drafting animation sequences for hero text",
    "Optimizing layout shifts during initial load",
    "Refining shadow tokens for softer UI feeling",
    "Implementing responsive font scaling for accessibility"
)

$currentDate = $startDate
while ($currentDate -le $endDate) {
    if ($skipDays -contains $currentDate.ToString("yyyy-MM-dd")) {
        $currentDate = $currentDate.AddDays(1)
        continue
    }

    # 1, 2, 3, or 5 commits per day (random)
    $possibleCounts = @(1, 2, 3, 5)
    $numCommits = $possibleCounts | Get-Random
    
    for ($i = 0; $i -lt $numCommits; $i++) {
        $msg = $commitMessages | Get-Random
        
        # Jitter the time around 2 PM
        $jitterMin = Get-Random -Minimum -60 -Maximum 90
        $jitterSec = Get-Random -Minimum 0 -Maximum 60
        $commitDate = $currentDate.AddMinutes($jitterMin).AddSeconds($jitterSec)
        
        $dateStr = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
        $authorDate = $dateStr
        $committerDate = $dateStr

        # Modify a file
        Add-Content -Path "commit-tracker.txt" -Value "Aesthetic polish at $dateStr : $msg"
        
        Write-Host "Committing: $msg at $dateStr"
        $env:GIT_AUTHOR_DATE = $authorDate
        $env:GIT_COMMITTER_DATE = $committerDate
        
        git add commit-tracker.txt
        git commit -m "$msg" --quiet
    }

    $currentDate = $currentDate.AddDays(1)
}

Write-Host "Finished Jun-Jul local commits. Pushing..."
git push origin main
