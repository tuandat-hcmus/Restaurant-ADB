import TopBar from 'src/components/TopBar'

export default function MainLayout({children}) {

  return (
    <main>
      <TopBar />
      {children}
    </main>
  )
}
