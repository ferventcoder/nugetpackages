﻿Install-ChocolateyZipPackage 'sumatrapdf.commandline' 'https://kjkpub.s3.amazonaws.com/sumatrapdf/rel/SumatraPDF-2.3.2.zip' "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
