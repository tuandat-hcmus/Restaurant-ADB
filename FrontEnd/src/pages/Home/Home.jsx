import TopBar from 'src/components/TopBar'
import { Link } from 'react-router-dom'
import authApi from '../../apis/AuthApi'
import { useContext } from 'react'
import { AppContext } from 'src/contexts/AppContext'
export default function Home() {
  const { setIsAuth, setIsCusAuth } = useContext(AppContext)
  const handleLogout = () => {
    authApi.logout()
    setIsAuth(false)
    setIsCusAuth(false)
  }
  return (
    <>
      <TopBar />
      <h1>Home page</h1>
      <Link to='/login'>Log in</Link>
      <button onClick={handleLogout}>logout</button>
    </>
  )
}
