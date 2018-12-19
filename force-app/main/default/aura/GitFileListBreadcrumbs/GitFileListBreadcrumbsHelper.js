({
    setPathParts : function(component) {

        var currentPath = component.get('v.currentPath');
        var parts = currentPath.split('/');

        var completeParts = [];
        var acumPath = '';

        parts.forEach(function(part) {
            
            if (acumPath) {
                acumPath += '/';
            }

            acumPath += part;
            completeParts.push({
                label: part,
                fullPath: acumPath
            });
        });

        component.set('v.pathParts', completeParts);
    }
})
