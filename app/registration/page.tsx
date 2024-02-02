// // RegistrationPage.tsx
// "use client";
// import { useState } from 'react';
// import Link from 'next/link'; 
// import styles from './styles.module.css';

// const RegistrationPage: React.FC = () => {
//   // State to hold form input values
//   const [username, setUsername] = useState('');
//   const [email, setEmail] = useState('');
//   const [password, setPassword] = useState('');
//   const [registrationStatus, setRegistrationStatus] = useState('');

//   const handleRegistration = async (e: React.FormEvent) => {
//     e.preventDefault();

//     try {
//       const response = await fetch('/api/register', {
//         method: 'POST',
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: JSON.stringify({ username, email, password }),
//       });

//       console.log(username);
//       console.log(email);
//       console.log(password);

//       if (response.ok) {
//         const result = await response.json();
//         setRegistrationStatus('Success');
//       } else {
//         const result = await response.json();
//         setRegistrationStatus('Failed');
//       }
//     } catch (error) {
//       console.error('Registration failed:', error);
//       setRegistrationStatus('Failed');
//     }
//   };

//   return (
//     <div className={styles.registrationContainer}>
//       <h1 className={styles.heading}>Register</h1>
//       <form onSubmit={handleRegistration} className={styles.form}>
//         <label className={styles.formLabel}>
//           Username:
//           <input type="text" value={username} onChange={(e) => setUsername(e.target.value)} className={styles.formInput} />
//         </label>
//         <br />
//         <label className={styles.formLabel}>
//           Email:
//           <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} className={styles.formInput} />
//         </label>
//         <br />
//         <label className={styles.formLabel}>
//           Password:
//           <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} className={styles.formInput} />
//         </label>
//         <br />
//         <button type="submit" className={styles.submitButton}>
//           Register
//         </button>
//       </form>

//       {registrationStatus && (
//         <div className={styles.registrationStatus}>
//           {registrationStatus === 'Success' ? (
//             <p>Registration successful! You can now <Link href="/login">log in</Link></p>
//           ) : (
//             <p>Registration failed. Please check your information and try again.</p>
//           )}
//         </div>
//       )}

//       {/* Button to navigate to the login page */}
//       <div className={styles.switchToLogin}>
//         <p>Already have an account? <Link href="/login">Login</Link></p>
//       </div>
//     </div>
//   );
// };

// export default RegistrationPage;



'use client';

import Link from 'next/link';
import React, { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import axios from 'axios';
import { FaAngleLeft } from 'react-icons/fa6';

export default function SignUpPage() {
	// redirect to login page
	const router = useRouter();

	const [user, setUser] = React.useState({
		username: '',
		email: '',
		password: '',
	});

	const [buttonDisabled, setButtonDisabled] = React.useState(false);

	const [loading, setLoading] = React.useState(false);

	const onSignUp = async () => {
		try {
			setLoading(true);

			const response = await axios.post('/api/register', user);
			console.log('signup okay', response.data);
			router.push('/login');
		} catch (error: any) {
			console.log('Failed to sign up the user', error.message);
		} finally {
			setLoading(false);
		}
	};

	useEffect(() => {
		if (
			user.username.length > 0 &&
			user.email.length > 0 &&
			user.password.length > 0
		) {
			setButtonDisabled(false);
		} else {
			setButtonDisabled(true);
		}
	}, [user]);

	console.log(user);

	return (
		<div className="flex flex-col items-center justify-center min-h-screen py-2">
			<h1 className="py-10 mb-10 text-5xl">
				{loading ? 'Processing...' : 'Free Sign Up'}
				<span className="italic text-sm absolute top-50 ml-4 text-green-600">
					for free until November 2023
				</span>
			</h1>

			<input
				className="w-[350px] text-slate-800 p-2 border border-gray-300 rounded-lg mb-4 focus:outline-none focus:border-gray-600"
				id="username"
				type="text"
				value={user.username}
				onChange={(e) => setUser({ ...user, username: e.target.value })}
				placeholder="Your Username..."
			/>

			<input
				className="w-[350px] text-slate-800 p-2 border border-gray-300 rounded-lg mb-4 focus:outline-none focus:border-gray-600"
				id="email"
				type="text"
				value={user.email}
				onChange={(e) => setUser({ ...user, email: e.target.value })}
				placeholder="Your Email..."
			/>

			<input
				className="w-[350px] text-slate-800 p-2 border border-gray-300 rounded-lg mb-4 focus:outline-none focus:border-gray-600"
				id="password"
				type="password"
				value={user.password}
				onChange={(e) => setUser({ ...user, password: e.target.value })}
				placeholder="Your Password..."
			/>

			<button
				onClick={onSignUp}
				className="p-2 border border-gray-300 rounded-lg focus:outline-none focus:border-gray-600 uppercase px-40 py-3 mt-10 font-bold">
				{buttonDisabled ? 'Sign Up' : 'Register My Account Now'}
			</button>

			<Link href="/login">
				<p className="mt-10">
					Do you have a free account already?{' '}
					<span className="font-bold text-green-600 ml-2 cursor-pointer underline">
						Login to your account
					</span>
				</p>
			</Link>

			<Link href="/">
				<p className="mt-8 opacity-50">
					<FaAngleLeft className="inline mr-1" /> Back to the Homepage
				</p>
			</Link>
		</div>
	);
}

