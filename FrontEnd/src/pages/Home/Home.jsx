import TopBar from 'src/components/TopBar'
import {Link} from 'react-router-dom'
export default function Home() {
  return (
    <>
      <TopBar />
      <h1>Home page</h1>
      <Link to='/login'>Log in</Link>
    </>
  )
}
