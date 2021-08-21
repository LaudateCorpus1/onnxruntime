# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

$ort_dirs = Get-ChildItem -Name -Path Microsoft.ML.OnnxRuntime*.nupkg  | Where-Object { ($_ -notmatch "Microsoft.ML.OnnxRuntime.Managed.*") }
Write-Output ($ort_dirs | Measure-Object).Count
if(($ort_dirs | Measure-Object).Count -ne 1)
{
	throw "length mismatch"
}
foreach ($nuget_file in $ort_dirs)
{
	mkdir runtimes\win-x86\native
	mkdir runtimes\win10-arm\native
	mkdir runtimes\win10-arm64\native
	mkdir runtimes\linux-x64\native
	mkdir runtimes\linux-aarch64\native
	mkdir runtimes\osx.10.14-x64\native
	mkdir runtimes\osx.10.14-arm64\native
	Rename-Item -Path onnxruntime-win-x86\lib\onnxruntime.dll -NewName runtimes\win-x86\native\onnxruntime.dll
	Rename-Item -Path onnxruntime-win-x86\lib\onnxruntime.lib -NewName runtimes\win-x86\native\onnxruntime.lib
	Rename-Item -Path onnxruntime-win-x86\lib\onnxruntime.pdb -NewName runtimes\win-x86\native\onnxruntime.pdb
	Rename-Item -Path onnxruntime-win-arm64\lib\onnxruntime.dll -NewName runtimes\win10-arm64\native\onnxruntime.dll
	Rename-Item -Path onnxruntime-win-arm64\lib\onnxruntime.lib -NewName runtimes\win10-arm64\native\onnxruntime.lib
	Rename-Item -Path onnxruntime-win-arm64\lib\onnxruntime.pdb -NewName runtimes\win10-arm64\native\onnxruntime.pdb
	Rename-Item -Path onnxruntime-win-arm\lib\onnxruntime.dll -NewName runtimes\win10-arm\native\onnxruntime.dll
	Rename-Item -Path onnxruntime-win-arm\lib\onnxruntime.lib -NewName runtimes\win10-arm\native\onnxruntime.lib
	Rename-Item -Path onnxruntime-win-arm\lib\onnxruntime.pdb -NewName runtimes\win10-arm\native\onnxruntime.pdb
	Rename-Item -Path onnxruntime-linux-x64\lib\libonnxruntime.so.1* -NewName runtimes\linux-x64\native\libonnxruntime.so
	Rename-Item -Path onnxruntime-linux-aarch64\lib\libonnxruntime.so.1* -NewName runtimes\linux-aarch64\native\libonnxruntime.so
	Rename-Item -Path onnxruntime-osx-x64\lib\libonnxruntime.*.dylib -NewName runtimes\osx.10.14-x64\native\libonnxruntime.dylib
	Rename-Item -Path onnxruntime-osx-arm64\lib\libonnxruntime.*.dylib -NewName runtimes\osx.10.14-arm64\native\libonnxruntime.dylib
	7z a  $nuget_file runtimes
}
