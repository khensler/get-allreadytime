$stat = 'cpu.ready.summation'
$entity =  Get-VM

Get-Stat -realtime -maxsamples 1 -Entity $entity -Stat $stat -ErrorAction SilentlyContinue | Group-Object -Property {$_.Entity.Name} | %{
  $_.Group | %{
    New-Object PSObject -Property @{
      VM = $_.Entity.Name
      Date = $_.Timestamp
      ReadyMs = $_.Value
      ReadyPerc = "{0:P2}" -f ($_.Value/($_.Intervalsecs*1000))
    }
  }
} | export-csv ready.txt
