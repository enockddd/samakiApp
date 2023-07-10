const jwt = require('jsonwebtoken');
const admin = require('firebase-admin');
require('dotenv').config();

// Initialize Firebase Admin SDK
const admin = require('firebase-admin');
const serviceAccount = require('./newsamakiapp-firebase-adminsdk-v2x74-49cc01d2a8.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const googleSignIn = async (req, res) => {
  try {
    const { idToken } = req.body;
    const credential = admin.auth.GoogleAuthProvider.credential(idToken);
    const userCredential = await admin.auth().signInWithCredential(credential);
    const { uid, email } = userCredential.user;

    // Generate JWT token
    const token = jwt.sign({ uid, email }, process.env.JWT_SECRET, { expiresIn: '1h' });

    res.json({ uid, email, token });
    console.log(uid)
    console.log(email)
  } catch (error) {
    console.error('Error signing in with Google:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports = {
  googleSignIn,
};
