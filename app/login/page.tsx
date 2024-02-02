// "use client"
// import { useEffect, useState } from 'react';
// import { useRouter } from 'next/navigation';
// import styles from './styles.module.css'
// import Link from 'next/link';


// const LoginPage: React.FC = () => {
//   const [email, setEmail] = useState('');
//   const [password, setPassword] = useState('');
//   const [loginStatus, setLoginStatus] = useState('');
//   const router = useRouter();

//   const handleLogin = async (e: React.FormEvent) => {
//     e.preventDefault();

//     try {
//       const response = await fetch('/api/login', {
//         method: 'POST',
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: JSON.stringify({ email, password }),
//       });

//       if (response.ok) {
//         const result = await response.json();
//         const token = result.token;
//         localStorage.setItem('authToken', token);

//         setLoginStatus("Success");
//       } else {
//         const result = await response.json();
//         setLoginStatus(`Login failed: ${result.message}`);
//       }
//     } catch (error) {
//       console.error('Error during login:', error);
//       setLoginStatus('Internal Server Error');
//     }
//   };

//   // Use useEffect to handle redirection
//   useEffect(() => {
//     if (loginStatus === 'Success') {
//       router.push('/home');
//     }
//   }, [loginStatus, router]);


//   return (
//     <div className={styles.loginContainer}>
//       <h1 className={styles.heading}>Login</h1>
//       <form onSubmit={handleLogin} className={styles.form}>
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
//           Login
//         </button>
//       </form>

//       {loginStatus && (
//         <div className={styles.loginStatus}>
//           {loginStatus === 'Success' ? (
//             <p>Login successful!</p>
//           ) : (
//             <p>Login failed. Please check your email and password.</p>
//           )}
//         </div>
//       )}

//       <div className={styles.switchToRegistration}>
//         <p>Don't have an account? <Link href="/registration">Register</Link></p>
//       </div>
//     </div>
//   );
// };

// export default LoginPage;




'use client';

import Link from 'next/link';
import React, { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import axios from 'axios';
import { FaAngleLeft } from 'react-icons/fa6';

export default function LoginPage() {
	const router = useRouter();

	const [user, setUser] = React.useState({
		email: '',
		password: '',
	});

	const [buttonDisabled, setButtonDisabled] = React.useState(false);

	const [loading, setLoading] = React.useState(false);

	const onLogin = async () => {
		try {
			setLoading(true);
			const response = await axios.post('api/login', user);
			console.log('Login successful', response.data);
			router.push('/home');
		} catch (error: any) {
			console.log('Login failed', error.message);
		} finally {
			setLoading(false);
		}
	};

	useEffect(() => {
		if (user.email.length > 0 && user.password.length > 0) {
			setButtonDisabled(false);
		} else {
			setButtonDisabled(true);
		}
	}, [user]);

	console.log(user);

	return (
		<div className="flex flex-col items-center justify-center min-h-screen py-2">
			<h1 className="py-10 mb-10 text-5xl">
				{loading ? "We're logging you in..." : 'Account Login'}
			</h1>

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
				onClick={onLogin}
				className="p-2 border border-gray-300 rounded-lg focus:outline-none focus:border-gray-600 uppercase px-40 py-3 mt-10 font-bold">
				Login
			</button>

			<Link href="/registration">
				<p className="mt-10">
					Do not have an account yet?
					<span className="font-bold text-green-600 ml-2 cursor-pointer underline">
						Register your free account now
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

