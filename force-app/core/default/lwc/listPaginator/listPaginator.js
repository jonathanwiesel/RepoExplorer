import { LightningElement, api } from 'lwc';

export default class ListPaginator extends LightningElement {

    @api size = 10;
    @api hasNext = false;
    @api hasPrevious = false;
    @api isLoading = false;

    page = 1;

    @api getCurrentPage() {
        return this.page;
    }

    @api getPageSize() {
        return this.size;
    }

    @api resetPage() {
        this.poge = 1;
    }

    get visible() {
        return this.hasNext || this.hasPrevious;
    }

    get disablePrev() {
        return this.hasPrevious || this.isLoading;
    }

    get disableNext() {
        return this.hasNext || this.isLoading;
    }

    nextPage() {

        this.page++;
        this.notifyPageChange();
    }

    previousPage() {

        this.page--;
        this.notifyPageChange();
    }

    notifyPageChange() {
        this.dispatchEvent(new CustomEvent('pagechanged', {
            detail: {
                page: this.page
            }
        }));
    }
}