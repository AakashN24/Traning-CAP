const cds = require('@sap/cds')
const moment = require('moment');
const { query } = require('express');


module.exports = async function () {

    const db = await cds.connect.to('db') // connect to database service
    // const db = await cds.connect.to('db') // connect to database service
    const { Incidents, Customers, MeasPoint, MeasPoint1 } = this.entities         // get reflected definitions

    const service1 = await cds.connect.to('JMREUSABLE_SB');

    this.on('READ', [MeasPoint, MeasPoint1], req => {
        return service1.tx(req).run(req.query);
    });

    this.before('CREATE', 'Incidents', (req) => {
        console.log('this.before(CREATE,Incidents) is triggered');
        console.log(req.data);
        if (req.data.urgencyCode == null) {
            req.data.urgencyCode = req.data.urgency_code;
        }
        // add();
    })

    this.on('ChangeUrgencytoHigh', async (req) => {
        console.log('ChangeUrgencytoHigh is triggered');
        console.log(req.params);
        // console.log(req.data);
        const query = await SELECT(Incidents).where({ ID: req.params[0].ID });

        if (query[0].urgency_code != 'H') {
            const n = await UPDATE(Incidents).set({ urgencyCode: 'H', urgency_code: 'H' }).where({ ID: req.params[0].ID })
            req.notify('Status Changed to High');
        }
        else {
            req.error('error')
        }
        // add();
    })


    this.on('getCurrentStatus', async (req) => {
        console.log('getCurrentStatus is triggered');
        console.log(req.params);
        const query = await SELECT(Incidents).where({ ID: req.params[0].ID });

        // const tx = await cds.connect.to('JMREUSABLE_SB')
        // var query2 = await tx.send({method: 'GET', path: 'MeasPoint'});
        // // const query1 = await SELECT(MeasPoint1).where({MPoint : '111'});
        // console.log('query2', query2);
        // console.log('query', query);
        moment();
        return query[0].status_code;

    });

    // function add() {

    // };

}