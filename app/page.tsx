
import logo from '/public/images/cpu.png'
import Image from 'next/image';
import styles from './styles.module.css'
import NavComponent from './components/navbar';
import ItemSlider from "./components/slider/page"; // Adjust this import based on your folder structure

<link
  href="https://api.mapbox.com/mapbox-gl-js/v2.8.1/mapbox-gl.css"
  rel="stylesheet"
/>;

interface NavComponentProps {
  message?: string;
}


export default async function Home() {

    
  return (
    <main>
      <div className={styles.topContainer}>
        <div className={styles.productsContainer}>
          <div className={styles.itemsSlider}>
            <h1>New devices</h1>
          </div>

          <div className={styles.itemsSlider}>
            <h1>New prices</h1>
          </div>

        </div>
      </div>
    </main>
  );
}

 
