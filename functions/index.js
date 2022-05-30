const functions = require("firebase-functions");
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

const db = admin.firestore();

exports.sendNotification = functions.firestore.document('contacts/{userId}/logs/{eventId}').onCreate( async (doc, context) => {

    const values = doc.data();

    const documentId = context.params.userId;
    const eventID = context.params.eventId;

    functions.logger.log(`'${doc.data()}`);
    functions.logger.log(`${doc.data().start}`);


    var collection = db.collection('contacts');
    var docSnapshot = await collection.doc(documentId).get();
    if (docSnapshot.exists) {
    var data = docSnapshot.data();
    var name = data['name'];
    var token = data['notification_token'];

    //var lastSeen = new admin.firestore.Timestamp.fromMillis(values.start); 

    await db.collection('logging').doc(documentId).set({login_event: `${values.start}`});

    var message = {
        notification: {
            title: 'Status',
            body: `${name} is online now!`,
            icon: ``,
        }
    }
    const response = await admin.messaging().sendToDevice(token, message);
    functions.logger.log('notification gönderildi');
    }

});