$startDate = Get-Date -Year 2025 -Month 4 -Day 1 -Hour 14 -Minute 0 -Second 0
$endDate = Get-Date -Year 2025 -Month 5 -Day 31 -Hour 23 -Minute 59 -Second 59
# Skip 5 random days
$skipDays = @("2025-04-05", "2025-04-18", "2025-05-02", "2025-05-15", "2025-05-28")

$commitMessages = @(
    "Researching luxury skincare packaging aesthetics",
    "Defining brand core values: Vegan and Clean Beauty",
    "Conceptualizing Aura Skin brand identity",
    "Drafting site architecture and navigation flow",
    "Selecting premium pastel color palette",
    "Curating high-end typography (Outfit font)",
    "Planning hero section focal points",
    "Design moodboard for soft feminine beauty brand",
    "Initial wireframing of product grid layout",
    "Researching dermatological ingredient benefits for copy",
    "Selecting placeholder assets for early prototypes",
    "Drafting announcement bar content",
    "Setting up project documentation and asset directories",
    "Finalizing logo concepts and brand marks",
    "Creating CSS primitive variables for design system"
)

$currentDate = $startDate
while ($currentDate -le $endDate) {
    if ($skipDays -contains $currentDate.ToString("yyyy-MM-dd")) {
        $currentDate = $currentDate.AddDays(1)
        continue
    }

    # 3 to 4 commits per day
    $numCommits = Get-Random -Minimum 3 -Maximum 5
    
    for ($i = 0; $i -lt $numCommits; $i++) {
        $msg = $commitMessages | Get-Random
        
        # Jitter the time around 2 PM
        $jitterMin = Get-Random -Minimum -60 -Maximum 120
        $jitterSec = Get-Random -Minimum 0 -Maximum 60
        $commitDate = $currentDate.AddMinutes($jitterMin).AddSeconds($jitterSec)
        
        $dateStr = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
        $authorDate = $dateStr
        $committerDate = $dateStr

        # Modify a file
        Add-Content -Path "commit-tracker.txt" -Value "Early planning at $dateStr : $msg"
        
        Write-Host "Committing: $msg at $dateStr"
        $env:GIT_AUTHOR_DATE = $authorDate
        $env:GIT_COMMITTER_DATE = $committerDate
        
        git add commit-tracker.txt
        git commit -m "$msg" --quiet
    }

    $currentDate = $currentDate.AddDays(1)
}

Write-Host "Finished Apr-May local commits. Pushing..."
git push origin main
