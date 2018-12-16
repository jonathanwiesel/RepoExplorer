({
    executeAction: function(component) {
        
        var file = component.get('v.file');

        switch (file.type) {
            case 'FILE':
                
                var fileSelected = $A.get('e.c:GitFileSelected');
                //fileSelected.setParams({ "myParam" : myValue });
                fileSelected.fire();

                break;
                
            case 'DIRECTORY':

                var dirSelected = component.getEvent('dirSelected');
                dirSelected.setParams({'selectedPath' : file.path});
                dirSelected.fire();
                break;

            default:
                break;
        }
    }
})