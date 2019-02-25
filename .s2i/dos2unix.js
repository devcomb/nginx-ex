/*********************************************************************
* Copyright (c) 2019 James Drummond
*
* This program and the accompanying materials are made
* available under the terms of the Eclipse Public License 2.0
* which is available at https://www.eclipse.org/legal/epl-2.0/
*
* SPDX-License-Identifier: EPL-2.0
**********************************************************************/

//Following is to convert all file in folder from dos format to unix.
//Is an issue with Theia where files are create in dos format
'use strict'
var fs = require('fs');
const dos2unix = require('ssp-dos2unix-js').dos2unix
 var dir = 'bin/';
 fs.readdir(dir, function(err, items) { 
    for (var i=0; i<items.length; i++) {
        var path = dir + items[i];
        let converted = dos2unix(path, {feedback: true, writable: false});
        fs.writeFile(path, converted, {mode:0o774}, function(err) {
            if(err) {
                return console.log(err);
            }
            console.log(items[i] + " converted.");
        }); 
    }
});

