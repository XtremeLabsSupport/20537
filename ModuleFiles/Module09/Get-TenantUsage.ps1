# Set date range for exported usage data
$reportedStartTime = Read-Host "What is the start date? Format required is YYYY-MM-DD"
$reportedEndTime = Read-Host "What is the end date? Format required is YYYY-MM-DD"


$granularity = "Hourly" # Can be Hourly or Daily
$showDetails = $true
# Export Usage to CSV
$appendFile = $false
$continuationToken = ""
$Results = @()
 
    $usageData = Get-UsageAggregates `
        -ReportedStartTime $reportedStartTime `
        -ReportedEndTime $reportedEndTime `
        -AggregationGranularity $granularity `
        -ShowDetails:$showDetails 
    $usageData.UsageAggregations.Properties | ?{$_.Quantity -gt 0} |
        Select-Object `
            UsageStartTime, `
            UsageEndTime, `
            MeterId, `
            Quantity, `
            InstanceData | %{$results += $_}


$Results | Select -First 100 | FT -AutoSize