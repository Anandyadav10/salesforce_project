import { LightningElement } from 'lwc';
export default class ShowroomHome extends LightningElement {
    get links(){return [
        {key:'leads',label:'Customer Leads',icon:'standard:lead'},
        {key:'opportunities',label:'Vehicle Sales',icon:'standard:opportunity'},
        {key:'bookings',label:'Car Bookings',icon:'standard:orders'},
        {key:'serviceAppointments',label:'Service Visits',icon:'standard:service_appointment'},
        {key:'reports',label:'Reports',icon:'standard:report'},
        {key:'dashboards',label:'Dashboards',icon:'standard:dashboard'}
    ];}
    go(e){this.dispatchEvent(new CustomEvent('navigate',{detail:{key:e.currentTarget.dataset.key},bubbles:true,composed:true}));}
}
