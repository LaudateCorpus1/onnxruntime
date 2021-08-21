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
	7z a  $nuget_file runtimes
}
