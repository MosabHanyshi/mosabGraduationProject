
export const metadata = {
  title: "categories page",
};

export default function CategoriesLayout({ children }: { children: React.ReactNode }) {
  return (
    <div>
      <h1>Categories</h1>
      <div 
         style ={{
            marginTop:"50px", 
            background:"blue",
            padding:"20px",
            borderRadius:"10px"
            }}
            >
           {children}
      </div>
    </div>
  );
}