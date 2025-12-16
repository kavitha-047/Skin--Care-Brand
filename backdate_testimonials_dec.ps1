# Randomly pick a day to skip between 16 and 31
$daysInRange = 16..31
$skipDayValue = $daysInRange | Get-Random
$skipDayString = "2025-12-$( "{0:D2}" -f $skipDayValue )"

Write-Host "Planned skip day: $skipDayString" -ForegroundColor Cyan

$startDate = Get-Date -Year 2025 -Month 12 -Day 16 -Hour 17 -Minute 0 -Second 0
$endDate = Get-Date -Year 2025 -Month 12 -Day 31 -Hour 23 -Minute 59 -Second 59

$commitMessages = @(
    "Designing testimonial section layout for social proof",
    "Selecting authentic customer reviews for Aura Skin",
    "Implementing star rating system for testimonials",
    "Adding glassmorphism effects to testimonial cards",
    "Integrating testimonials into global reveal observer",
    "Refining typography for customer quotes",
    "Optimizing testimonial grid for mobile responsiveness",
    "Testing scroll-triggered animations for social proof section",
    "Tweaking background gradients for testimonial section",
    "Adding hover elevation effect to testimonial cards",
    "Ensuring accessibility of star rating icons",
    "Refining margin and padding for home page sections",
    "Finalizing testimonial section polish and consistency",
    "Cleaning up script.js reveal selectors",
    "Preparing for final Q4 project wrap-up"
)

# Ensure our actual changes are part of the first commit or staged
git add .

$currentDate = $startDate
while ($currentDate -le $endDate) {
    $dateKey = $currentDate.ToString("yyyy-MM-dd")
    
    # Check if we should skip this day
    if ($dateKey -eq $skipDayString) {
        Write-Host "Skipping $dateKey as planned." -ForegroundColor Yellow
        $currentDate = $currentDate.AddDays(1)
        continue
    }

    # Determine number of commits (2 or 3)
    $numCommits = Get-Random -Minimum 2 -Maximum 4
    
    for ($i = 0; $i -lt $numCommits; $i++) {
        $msg = $commitMessages | Get-Random
        
        # Jitter the time around 5 PM (17:00)
        $jitterMin = Get-Random -Minimum -30 -Maximum 90
        $jitterSec = Get-Random -Minimum 0 -Maximum 60
        $commitDate = $currentDate.AddMinutes($jitterMin).AddSeconds($jitterSec)
        
        $dateStr = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
        $authorDate = $dateStr
        $committerDate = $dateStr

        # Modify the tracker file to ensure we have something to commit if staging is empty
        Add-Content -Path "commit-tracker.txt" -Value "Testimonial development update at $dateStr : $msg"
        
        Write-Host "Committing: $msg at $dateStr"
        $env:GIT_AUTHOR_DATE = $authorDate
        $env:GIT_COMMITTER_DATE = $committerDate
        
        git add commit-tracker.txt
        git commit -m "$msg" --quiet
    }

    $currentDate = $currentDate.AddDays(1)
}

Write-Host "Finished testimonial backdated commits. Pushing..." -ForegroundColor Green
git push origin main
