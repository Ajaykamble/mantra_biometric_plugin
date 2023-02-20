var MAX_PORT=11120;

function jsgetDeviceInfo(port) {
    
    return new Promise(async (resolve, reject) => {

        var xhr = new XMLHttpRequest();
        xhr.open('DEVICEINFO', 'http://localhost:' + port + '/rd/info', true);
        xhr.responseType = 'text';
        xhr.onerror = function (e) {
            if(port<MAX_PORT)
            {
                port++;
                resolve(jsgetDeviceInfo(port));
            }
            else{
                reject("ClientNotFound");
            }
        }
        xhr.ontimeout = function () {
            reject("ClientNotFound");
        }
        xhr.onload = function () {
            var status = xhr.status;
            if (status == 200) {
                resolve(xhr.response);
            } else {
                resolve(status);
            }
        };
        xhr.send();
    });

}
async function jscaptureFingerPrint(pidOptions,port) {
    return new Promise(async (resolve, reject) => {

        var xhr = new XMLHttpRequest();
        xhr.open('DEVICEINFO', 'http://localhost:' + port + '/rd/info', true);
        xhr.responseType = 'text';
        xhr.onerror = function (e) {
            if(port<MAX_PORT)
            {
                port++;
                resolve(jscaptureFingerPrint(pidOptions,port));
            }
            else{
                reject("ClientNotFound");
            }
        }
        xhr.ontimeout = function () {
            reject("ClientNotFound");
        }
        xhr.onload = function () {
            var status = xhr.status;
            if (status == 200) {
                resolve(capture(pidOptions,port));
            } else {
                resolve(status);
            }
        };
        xhr.send();
    });
}

function capture(pidOptions,port){
    return new Promise(async (resolve, reject) => {
        var xhr = new XMLHttpRequest();
        xhr.open('CAPTURE', 'http://localhost:' + port + '/rd/capture', true);
        xhr.responseType = 'text';
        xhr.onerror = function (e) {
            reject("ClientNotFound");
        }
        xhr.ontimeout = function () {
            reject("ClientNotFound");
        }
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                resolve(xhr.responseText);
            }
        }
        xhr.send(pidOptions);
    });
}