/* eslint-disable @next/next/no-img-element */

import React from "react";
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import styles from "./styles.module.css";




interface Product {
  product_id: number;
  product_name: string;
  product_price: number;
  product_count: number;
  product_category: string;
  product_img_path: string;
  product_description: string;
}

interface CarouselSliderProps {
  products: Product[]; 
  type: string;
}

const CarouselSlider: React.FC<CarouselSliderProps> = ({products,type}) => {
  const settings = {
    dots: true,
    infinite: true,
    speed: 500,
    slidesToShow: 3,
    slidesToScroll: 1,
  };

  return (
    <div className={styles.carouselContainer}>
      <Slider {...settings}>
        {products.map((product) => (
          <div key={product.product_id} className={styles.slide}>
            <div className={styles.slideContent}>
              {type=="new"?<div className={styles.newNotification}>New</div>:null}
              <div className={styles.imageContainer}>
                <img
                  src={product.product_img_path}
                  style={{
                    width: "100%",
                    height: "100%",
                    borderRadius: "inherit",
                  }}
                />
              </div>
            </div>
          </div>
        ))}
      </Slider>
    </div>
  );
};

export default CarouselSlider;
