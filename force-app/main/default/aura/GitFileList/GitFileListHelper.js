({
    fetchFiles : function(component) {

        var repo = component.get('v.repo');

        var params = {
            'stringifiedRepo': JSON.stringify(repo),
            'path': component.get('v.filesPath')
        };

        this.fetchData(component, 'c.getFileTree', params, 'tree');
    }
})
