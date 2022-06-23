#$env:Path
$folder=gci -force 'C:\' -ErrorAction SilentlyContinue | ? { $_ -is [io.directoryinfo] }|% {
$len = 0
$child_fullnames = gci -recurse -force $_.fullname -ErrorAction SilentlyContinue
foreach($child_fullname in $child_fullnames) {
$len += $child_fullname.length

}
new-object psobject -Property @{
Name = $_.name
Size = '{0:N2} GB' -f ($len / 1gb)
}

#$_.name, '{0:N2} MB' -f ($len / 1MB)
}
$folder |select Name, size | Sort-Object size -Descending | select -First 5