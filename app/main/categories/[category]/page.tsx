

// export default function showCategory(category:string){
//     return (
//     <div> show a {category}</div>);
// }

export default function showCategory({params}:{params : {category: string}}) {
  return(<div> show a {params.category}</div>);
}