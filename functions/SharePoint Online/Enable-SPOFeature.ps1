<#
$Metadata = @{
	Title = "Enable-SPOFeature"
	Filename = "Enable-SPOFeature.ps1"
	Description = ""
	Tags = "powershell, sharepoint, online"
	Project = "https://sharepointpowershell.codeplex.com"
	Author = "Jeffrey Paarhuis"
	AuthorContact = "http://jeffreypaarhuis.com/"
	CreateDate = "2013-02-2"
	LastEditDate = "2014-02-2"
	Url = ""
	Version = "0.1.2"
	License = @'
The MIT License (MIT)
Copyright (c) 2014 Jeffrey Paarhuis
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'@
}
#>

function Enable-SPOFeature
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$true, Position=1)]
	    [string]$featureId,
		
		[Parameter(Mandatory=$true, Position=2)]
	    [bool]$force,
		
		[Parameter(Mandatory=$true, Position=3)]
	    [Microsoft.SharePoint.Client.FeatureDefinitionScope]$featureDefinitionScope
	)
	Write-Host "Enabling feature $featureId on $featureDefinitionScope" -foregroundcolor black -backgroundcolor yellow
		
	$featureGuid = new-object System.Guid $featureId
		
	$features = $null	
	
	if ($featureDefinitionScope -eq [Microsoft.SharePoint.Client.FeatureDefinitionScope]::Site)
	{
	
		$features = $clientContext.Site.Features
		
	} else {
	
		$features = $clientContext.Web.Features
		
	}
	$clientContext.Load($features)
	$clientContext.ExecuteQuery()
	
	$feature = $features.Add($featureGuid, $force, [Microsoft.SharePoint.Client.FeatureDefinitionScope]::None)
	
	# TODO: Check if the feature is already enabled
	$clientContext.ExecuteQuery()
	
	Write-Host "Feature succesfully enabled" -foregroundcolor black -backgroundcolor green
}
