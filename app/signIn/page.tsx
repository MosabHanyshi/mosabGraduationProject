import { SignIn } from "@clerk/nextjs";
import styles from './styles.module.css';



export default function signIn(){
    return (
      <div className={styles.container}>
        <SignIn />
      </div>
    );
}