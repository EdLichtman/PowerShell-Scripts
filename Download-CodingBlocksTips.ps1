$outFileLocation = "C:\Users\elich\Desktop\TipsAndTricks.txt"
<#bad script -- if you're not running in Admin this reaches out and processes everything before finding deciding it doesn't have permissions. Fix Script or be selective of location#>
$latestEpisodeNum = 132
$totalEpisodes = 132
$episodeList = $latestEpisodeNum..($latestEpisodeNum-$totalEpisodes-1 <#0-indexed#>) | ForEach-Object { "https://codingblocks.net/episode$_" }
$tips = $episodeList | Select-Object -property @{N="InnerText";E={
    $ContentOfPage = (Invoke-WebRequest $_).ParsedHTML
    $tipOfTheWeekNode = $ContentOfPage.getElementsByTagName('h2') | where-object { $_.innerText -eq "Tip of the Week" }
    return $tipOfTheWeekNode.nextSibling().OuterHtml
}}, @{N="EpisodeNumber";E={$_}}
$tips | foreach-object { "<p><a href=""$($_.EpisodeNumber)"">$($_.EpisodeNumber)</a></p>$($_.InnerText)" | out-file $outFileLocation -Append }