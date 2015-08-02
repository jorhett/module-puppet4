class puppet::agent(
  # input parameters specific to agent subclass
  Enum['running','stopped'] $status  = 'running',
  Boolean $enabled,             # required parameter
) inherits puppet {
}
