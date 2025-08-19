pragma Singleton

// borrowed from caelestia-dots under GPL-3.0

import Quickshell

Singleton {
    id: root

    function get(url: string, callback: var): Promise {
        return new Promise((resolve, reject) => {
            const xhr = new XMLHttpRequest();

            const cleanup = () => {
                xhr.abort();
                xhr.onreadystatechange = null;
                xhr.onerror = null;
            };

            xhr.open("GET", url, true);
            xhr.onreadystatechange = () => {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200)
                        resolve(xhr.responseText);
                    else
                        console.warn(`[REQUESTS] GET request to ${url} failed with status ${xhr.status}`);
                        reject();
                    cleanup();
                }
            };
            xhr.onerror = () => {
                reject();
                console.warn(`[REQUESTS] GET request to ${url} failed`);
                cleanup();
            };

            xhr.send();
        });
    }
}
