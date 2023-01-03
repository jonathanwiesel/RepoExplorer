import { LightningElement, wire, api } from 'lwc';
import getRepositoriesInDomain from '@salesforce/apex/GitHostingRepoListRouter.getRepositoriesInDomain';

export default class GitRepoList extends LightningElement {

    @api hostingService
    @api owner;
    @api isUser = false;
    @api pageSize = 10;
    @api showDescription = false;

    page = 1;
    hasNext = false;
    hasPrev = false;    

    @wire(getRepositoriesInDomain, {
        hostingService: '$hostingService',
        isUser: '$isUser',
        domain: '$domain',
        page: '$page',
        pageSize: '$pageSize'
    })
    repos;

    selectRepo(event) {
        //TODO: dynamic interaction (notify selected repo)
    }

    updatePage(event) {
        this.page = event.detail.page;
    }
}