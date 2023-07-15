param(
[string] $funName
)

# Send Discord message informing that the automation is running
function startMessage {

$hookUrl = 'ENTER DISCORD WEBHOOK URL'

$content = @"
Keep PDI Alive is starting.
"@

$payload = [PSCustomObject]@{

    content = $content
    
}

Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'application/json'

}

# Send Discord message informing that the automation is complete
function endMessage {

$hookUrl = 'ENTER DISCORD WEBHOOK URL'

$content = @"
Keep PDI Alive has ended.
"@

$payload = [PSCustomObject]@{

    content = $content
    
}

Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'application/json'

}

# Using Home Assistant, Turn on the outlet that controls the automation monitor 
function monitorOn{

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer ENTER TOKEN")
$headers.Add("Content-Type", "application/json")

$body = "{
`n    `"entity_id`": `"ENTER ENTITY_ID`"
`n}"

$response = Invoke-RestMethod '**ENTER URI**/api/services/switch/turn_on' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json

}

# Using Home Assistant, Turn off the outlet that controls the automation monitor 
function monitorOff{

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer **ENTER TOKEN**")
$headers.Add("Content-Type", "application/json")

$body = "{
`n    `"entity_id`": `"**ENTER ENTITY_ID**`"
`n}"

$response = Invoke-RestMethod '**ENTER URI**/api/services/switch/turn_off' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json

}

# Run the function name in the $funName param
$thisFun = $funName

$scriptBlock = $(Get-Item Function:\$thisFun).ScriptBlock
$scriptBlock
Invoke-Command -ScriptBlock $scriptBlock