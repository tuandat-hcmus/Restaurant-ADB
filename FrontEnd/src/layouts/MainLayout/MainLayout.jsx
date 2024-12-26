// import { useState } from 'react'
// import TopBar from 'src/components/TopBar'
import Login from 'src/pages/Login'

export default function MainLayout() {
  // const [auth, setAuth] = useState(false)
  // const setLogin = () => {
  //   setAuth((prevAuth) => 
  //     !prevAuth
  //   )
  // }
  return (
    <main>
      {/* <TopBar auth={auth} />
      <button onClick={setLogin}>Login</button> */}
      <Login />
    </main>
  )
}
