import { UserButton } from '@clerk/nextjs';
import logo from '/public/images/cpu.png'
import Image from 'next/image';

export default function Home() {
  return (
    <main>
      <div
        style={{
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
          background: "#E0F4FF",
          width: "100vw",
          height: "100vh",
        }}
      >
        <div
          style={{
            display: "flex",
            flexDirection: "column",
            alignItems: "center",
            width: "220px",
            height: "200px",
            border: "5px solid #39A7FF",
            borderRadius: "30px",
            color: "white",
          }}
        >
          <div
            style={{
              display: "",
              color: "black",
              justifyContent: "center",
              alignItems: "center",
              margin: "10px",
            }}
          >
            <h1>Kabatokia Store</h1>
          </div>
          <div style={{}}>
            <Image
              src={logo}
              alt="logo"
              style={{
                display: "flex",
                width: "100px",
                height: "100px",
                justifyContent: "center",
                alignItems: "center",
              }}
            />
          </div>
        </div>
        <UserButton afterSignOutUrl="/" />
      </div>
    </main>
  );
}
