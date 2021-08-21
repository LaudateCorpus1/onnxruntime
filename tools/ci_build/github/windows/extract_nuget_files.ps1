# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

New-Item -Path $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\nuget-artifacts -ItemType directory

Get-ChildItem $Env:BUILD_BINARIESDIRECTORY\nuget-artifact -Filter *.zip | 
Foreach-Object {
 $cmd = "7z.exe x $($_.FullName) -y -o$Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\nuget-artifacts"
 Write-Output $cmd
 Invoke-Expression -Command $cmd
}

Get-ChildItem $Env:BUILD_BINARIESDIRECTORY\nuget-artifact -Filter *.tgz | 
Foreach-Object {
 $cmd = "7z.exe x $($_.FullName) -y -o$Env:BUILD_BINARIESDIRECTORY\nuget-artifact"
 Write-Output $cmd
 Invoke-Expression -Command $cmd
}

Get-ChildItem $Env:BUILD_BINARIESDIRECTORY\nuget-artifact -Filter *.tar | 
Foreach-Object {
 $cmd = "7z.exe x $($_.FullName) -y -o$Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\nuget-artifacts"
 Write-Output $cmd
 Invoke-Expression -Command $cmd
}


New-Item -Path $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\external\protobuf\cmake\RelWithDebInfo -ItemType directory

Copy-Item -Path $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\nuget-artifacts\onnxruntime-win-x64-*\lib\* -Destination $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo
Copy-Item -Path $Env:BUILD_BINARIESDIRECTORY\extra-artifact\protoc.exe $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\external\protobuf\cmake\RelWithDebInfo

$ort_dirs = Get-ChildItem -Path $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\nuget-artifacts\onnxruntime-* -Directory
foreach ($ort_dir in $ort_dirs)
{
  
  Write-Output "Renaming $ort_dir"
  $dirname = Split-Path -Path $ort_dir -Leaf
  $dirname = $dirname.SubString(0,$dirname.LastIndexOf('-'))
  Write-Output "Renaming to $dirname"
  Rename-Item -Path $ort_dir -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\nuget-artifacts\$dirname  
}

cd $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo
mkdir runtimes\win-x86\native
mkdir runtimes\win10-arm\native
mkdir runtimes\win10-arm64\native
mkdir runtimes\linux-x64\native
mkdir runtimes\linux-aarch64\native
mkdir runtimes\osx.10.14-x64\native
mkdir runtimes\osx.10.14-arm64\native
cd nuget-artifacts
Rename-Item -Path onnxruntime-win-x86\lib\onnxruntime.dll -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\win-x86\native\onnxruntime.dll
Rename-Item -Path onnxruntime-win-x86\lib\onnxruntime.lib -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\win-x86\native\onnxruntime.lib
Rename-Item -Path onnxruntime-win-x86\lib\onnxruntime.pdb -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\win-x86\native\onnxruntime.pdb
Rename-Item -Path onnxruntime-win-arm64\lib\onnxruntime.dll -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\win10-arm64\native\onnxruntime.dll
Rename-Item -Path onnxruntime-win-arm64\lib\onnxruntime.lib -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\win10-arm64\native\onnxruntime.lib
Rename-Item -Path onnxruntime-win-arm64\lib\onnxruntime.pdb -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\win10-arm64\native\onnxruntime.pdb
Rename-Item -Path onnxruntime-win-arm\lib\onnxruntime.dll -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\win10-arm\native\onnxruntime.dll
Rename-Item -Path onnxruntime-win-arm\lib\onnxruntime.lib -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\win10-arm\native\onnxruntime.lib
Rename-Item -Path onnxruntime-win-arm\lib\onnxruntime.pdb -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\win10-arm\native\onnxruntime.pdb
Rename-Item -Path onnxruntime-linux-x64\lib\libonnxruntime.so.1* -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\linux-x64\native\libonnxruntime.so
Rename-Item -Path onnxruntime-linux-aarch64\lib\libonnxruntime.so.1* -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\linux-aarch64\native\libonnxruntime.so
Rename-Item -Path onnxruntime-osx-x64\lib\libonnxruntime.*.dylib -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\osx.10.14-x64\native\libonnxruntime.dylib
Rename-Item -Path onnxruntime-osx-arm64\lib\libonnxruntime.*.dylib -NewName $Env:BUILD_BINARIESDIRECTORY\RelWithDebInfo\RelWithDebInfo\runtimes\osx.10.14-arm64\native\libonnxruntime.dylib
