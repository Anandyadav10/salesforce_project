import { LightningElement } from 'lwc';
export default class ShowroomReports extends LightningElement {
    selectedLabel='Sales Report';
    get reports(){return [
        {key:'sales',label:'Sales Report',description:'Vehicle sales and revenue'},
        {key:'booking',label:'Booking Report',description:'Booking pipeline'},
        {key:'inventory',label:'Inventory Report',description:'Vehicle stock'},
        {key:'service',label:'Service Report',description:'Appointments and jobs'},
        {key:'parts',label:'Spare Parts Report',description:'Parts stock and usage'},
        {key:'finance',label:'Finance Report',description:'Invoices and collections'},
        {key:'insurance',label:'Insurance Report',description:'Policy records'},
        {key:'rto',label:'RTO Report',description:'Registrations'},
        {key:'customer',label:'Customer Report',description:'Customer records'},
        {key:'collection',label:'Collection Report',description:'Payment collection'}
    ]; }
    openReport(e){const r=this.reports.find(x=>x.key===e.currentTarget.dataset.key);this.selectedLabel=r.label;}
    print(){window.print();}
}
