import { Drawer, List, ListItem, ListItemText } from '@mui/material'

export default function SideBar() {
  return (
    <Drawer variant='permanent' sx={{flexShrink: 0 }}>
      <List>
        <ListItem>
          <ListItemText primary='Dashboard iiiiiiiiiiiiiiiiiiiiiiiiiiiiii' />
        </ListItem>
      </List>
    </Drawer>
  )
}
