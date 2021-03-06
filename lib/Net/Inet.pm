# Copyright 1995,2002 Spider Boardman.
# All rights reserved.
#
# Automatic licensing for this software is available.  This software
# can be copied and used under the terms of the GNU Public License,
# version 1 or (at your option) any later version, or under the
# terms of the Artistic license.  Both of these can be found with
# the Perl distribution, which this software is intended to augment.
#
# THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
# WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

# rcsid: "@(#) $Id: Inet.dat,v 1.26 2002/03/30 10:10:39 spider Exp $"

package Net::Inet;
use 5.004_04;			# new minimum Perl version for this package

use strict;
# use Carp;
sub croak { require Carp; goto &Carp::croak; }
sub carp { require Carp; goto &Carp::carp; }
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $AUTOLOAD);


BEGIN {
    $VERSION = '1.0';
    eval "sub Version () { __PACKAGE__ . ' v$VERSION' }";
}

use AutoLoader;
#use Exporter ();
use Net::Gen 1.0 qw(:ALL);
use Socket qw(/^inet_/);

BEGIN {
    @ISA = 'Net::Gen';

# Items to export into callers namespace by default
# (move infrequently used names to @EXPORT_OK below)
    @EXPORT = qw(
	INADDR_ALLHOSTS_GROUP
	INADDR_ALLRTRS_GROUP
	INADDR_ANY
	INADDR_BROADCAST
	INADDR_LOOPBACK
	INADDR_MAX_LOCAL_GROUP
	INADDR_NONE
	INADDR_UNSPEC_GROUP
	IPPORT_RESERVED
	IPPORT_USERRESERVED
	IPPORT_DYNAMIC
	IPPROTO_EGP
	IPPROTO_EON
	IPPROTO_GGP
	IPPROTO_HELLO
	IPPROTO_ICMP
	IPPROTO_IDP
	IPPROTO_IGMP
	IPPROTO_IP
	IPPROTO_IPIP
	IPPROTO_MAX
	IPPROTO_PUP
	IPPROTO_RAW
	IPPROTO_RSVP
	IPPROTO_TCP
	IPPROTO_TP
	IPPROTO_UDP
	htonl
	htons
	inet_addr
	inet_aton
	inet_ntoa
	ntohl
	ntohs
    );

# Other items we are prepared to export if requested
    @EXPORT_OK = qw(
	DEFTTL
	ICMP_ADVLENMIN
	ICMP_ECHO
	ICMP_ECHOREPLY
	ICMP_INFOTYPE
	ICMP_IREQ
	ICMP_IREQREPLY
	ICMP_MASKLEN
	ICMP_MASKREPLY
	ICMP_MASKREQ
	ICMP_MAXTYPE
	ICMP_MINLEN
	ICMP_PARAMPROB
	ICMP_REDIRECT
	ICMP_REDIRECT_HOST
	ICMP_REDIRECT_NET
	ICMP_REDIRECT_TOSHOST
	ICMP_REDIRECT_TOSNET
	ICMP_SOURCEQUENCH
	ICMP_TIMXCEED
	ICMP_TIMXCEED_INTRANS
	ICMP_TIMXCEED_REASS
	ICMP_TSLEN
	ICMP_TSTAMP
	ICMP_TSTAMPREPLY
	ICMP_UNREACH
	ICMP_UNREACH_HOST
	ICMP_UNREACH_NEEDFRAG
	ICMP_UNREACH_NET
	ICMP_UNREACH_PORT
	ICMP_UNREACH_PROTOCOL
	ICMP_UNREACH_SRCFAIL
	IN_BADCLASS
	IN_CLASSA
	IN_CLASSA_HOST
	IN_CLASSA_MAX
	IN_CLASSA_NET
	IN_CLASSA_NSHIFT
	IN_CLASSA_SUBHOST
	IN_CLASSA_SUBNET
	IN_CLASSA_SUBNSHIFT
	IN_CLASSB
	IN_CLASSB_HOST
	IN_CLASSB_MAX
	IN_CLASSB_NET
	IN_CLASSB_NSHIFT
	IN_CLASSB_SUBHOST
	IN_CLASSB_SUBNET
	IN_CLASSB_SUBNSHIFT
	IN_CLASSC
	IN_CLASSC_HOST
	IN_CLASSC_MAX
	IN_CLASSC_NET
	IN_CLASSC_NSHIFT
	IN_CLASSD
	IN_CLASSD_HOST
	IN_CLASSD_NET
	IN_CLASSD_NSHIFT
	IN_EXPERIMENTAL
	IN_LOOPBACKNET
	IN_MULTICAST
	IPFRAGTTL
	IPOPT_CIPSO
	IPOPT_CLASS
	IPOPT_CONTROL
	IPOPT_COPIED
	IPOPT_DEBMEAS
	IPOPT_EOL
	IPOPT_LSRR
	IPOPT_MINOFF
	IPOPT_NOP
	IPOPT_NUMBER
	IPOPT_OFFSET
	IPOPT_OLEN
	IPOPT_OPTVAL
	IPOPT_RESERVED1
	IPOPT_RESERVED2
	IPOPT_RIPSO_AUX
	IPOPT_RR
	IPOPT_SATID
	IPOPT_SECURITY
	IPOPT_SECUR_CONFID
	IPOPT_SECUR_EFTO
	IPOPT_SECUR_MMMM
	IPOPT_SECUR_RESTR
	IPOPT_SECUR_SECRET
	IPOPT_SECUR_TOPSECRET
	IPOPT_SECUR_UNCLASS
	IPOPT_SSRR
	IPOPT_TS
	IPOPT_TS_PRESPEC
	IPOPT_TS_TSANDADDR
	IPOPT_TS_TSONLY
	IPPORT_TIMESERVER
	IPTOS_LOWDELAY
	IPTOS_PREC_CRITIC_ECP
	IPTOS_PREC_FLASH
	IPTOS_PREC_FLASHOVERRIDE
	IPTOS_PREC_IMMEDIATE
	IPTOS_PREC_INTERNETCONTROL
	IPTOS_PREC_NETCONTROL
	IPTOS_PREC_PRIORITY
	IPTOS_PREC_ROUTINE
	IPTOS_RELIABILITY
	IPTOS_THROUGHPUT
	IPTTLDEC
	IPVERSION
	IP_ADD_MEMBERSHIP
	IP_DEFAULT_MULTICAST_LOOP
	IP_DEFAULT_MULTICAST_TTL
	IP_DF
	IP_DROP_MEMBERSHIP
	IP_HDRINCL
	IP_MAXPACKET
	IP_MAX_MEMBERSHIPS
	IP_MF
	IP_MSS
	IP_MULTICAST_IF
	IP_MULTICAST_LOOP
	IP_MULTICAST_TTL
	IP_OPTIONS
	IP_RECVDSTADDR
	IP_RECVOPTS
	IP_RECVRETOPTS
	IP_RETOPTS
	IP_TOS
	IP_TTL
	MAXTTL
	MAX_IPOPTLEN
	MINTTL
	SUBNETSHIFT
	pack_sockaddr_in
	unpack_sockaddr_in
    );

    %EXPORT_TAGS = (
	sockopts	=> [qw(IP_HDRINCL IP_RECVDSTADDR IP_RECVOPTS
			       IP_RECVRETOPTS IP_TOS IP_TTL IP_ADD_MEMBERSHIP
			       IP_DROP_MEMBERSHIP IP_MULTICAST_IF
			       IP_MULTICAST_LOOP IP_MULTICAST_TTL
			       IP_OPTIONS IP_RETOPTS)],
	routines	=> [qw(pack_sockaddr_in unpack_sockaddr_in
			       inet_ntoa inet_aton inet_addr
			       htonl ntohl htons ntohs
			       ICMP_INFOTYPE IN_BADCLASS
			       IN_EXPERIMENTAL IN_MULTICAST
			       IPOPT_CLASS IPOPT_COPIED IPOPT_NUMBER)],
	icmpvalues	=> [qw(ICMP_ADVLENMIN ICMP_ECHO ICMP_ECHOREPLY
			       ICMP_IREQ ICMP_IREQREPLY ICMP_MASKLEN
			       ICMP_MASKREPLY ICMP_MASKREQ ICMP_MAXTYPE
			       ICMP_MINLEN ICMP_PARAMPROB ICMP_REDIRECT
			       ICMP_REDIRECT_HOST ICMP_REDIRECT_NET
			       ICMP_REDIRECT_TOSHOST ICMP_REDIRECT_TOSNET
			       ICMP_SOURCEQUENCH ICMP_TIMXCEED
			       ICMP_TIMXCEED_INTRANS ICMP_TIMXCEED_REASS
			       ICMP_TSLEN ICMP_TSTAMP ICMP_TSTAMPREPLY
			       ICMP_UNREACH ICMP_UNREACH_HOST
			       ICMP_UNREACH_NEEDFRAG ICMP_UNREACH_NET
			       ICMP_UNREACH_PORT ICMP_UNREACH_PROTOCOL
			       ICMP_UNREACH_SRCFAIL)],
	ipoptions	=> [qw(IPOPT_CIPSO IPOPT_CONTROL IPOPT_DEBMEAS
			       IPOPT_EOL IPOPT_LSRR IPOPT_MINOFF IPOPT_NOP
			       IPOPT_OFFSET IPOPT_OLEN IPOPT_OPTVAL
			       IPOPT_RESERVED1 IPOPT_RESERVED2
			       IPOPT_RIPSO_AUX IPOPT_RR IPOPT_SATID
			       IPOPT_SECURITY IPOPT_SECUR_CONFID
			       IPOPT_SECUR_EFTO IPOPT_SECUR_MMMM
			       IPOPT_SECUR_RESTR IPOPT_SECUR_SECRET
			       IPOPT_SECUR_TOPSECRET IPOPT_SECUR_UNCLASS
			       IPOPT_SSRR
			       IPOPT_TS IPOPT_TS_PRESPEC
			       IPOPT_TS_TSANDADDR IPOPT_TS_TSONLY
			       MAX_IPOPTLEN)],
	iptosvalues	=> [qw(IPTOS_LOWDELAY IPTOS_PREC_CRITIC_ECP
			       IPTOS_PREC_FLASH IPTOS_PREC_FLASHOVERRIDE
			       IPTOS_PREC_IMMEDIATE IPTOS_PREC_INTERNETCONTROL
			       IPTOS_PREC_NETCONTROL IPTOS_PREC_PRIORITY
			       IPTOS_PREC_ROUTINE IPTOS_RELIABILITY
			       IPTOS_THROUGHPUT)],
	protocolvalues	=> [qw(DEFTTL
			       INADDR_ALLHOSTS_GROUP INADDR_ALLRTRS_GROUP
			       INADDR_ANY INADDR_BROADCAST INADDR_LOOPBACK
			       INADDR_MAX_LOCAL_GROUP INADDR_NONE
			       INADDR_UNSPEC_GROUP
			       IN_LOOPBACKNET
			       IPPORT_RESERVED IPPORT_USERRESERVED
			       IPPORT_DYNAMIC
			       IPPROTO_EGP IPPROTO_EON IPPROTO_GGP
			       IPPROTO_HELLO IPPROTO_ICMP IPPROTO_IDP
			       IPPROTO_IGMP IPPROTO_IP IPPROTO_IPIP
			       IPPROTO_MAX IPPROTO_PUP IPPROTO_RAW
			       IPPROTO_RSVP IPPROTO_TCP IPPROTO_TP
			       IPPROTO_UDP
			       IPFRAGTTL
			       IPTTLDEC IPVERSION
			       IP_DF IP_MAXPACKET IP_MF IP_MSS
			       MAXTTL MAX_IPOPTLEN MINTTL)],
	ipmulticast	=> [qw(IP_ADD_MEMBERSHIP IP_DEFAULT_MULTICAST_LOOP
			       IP_DEFAULT_MULTICAST_TTL IP_DROP_MEMBERSHIP
			       IP_MAX_MEMBERSHIPS IP_MULTICAST_IF
			       IP_MULTICAST_LOOP IP_MULTICAST_TTL)],
	deprecated	=> [qw(IN_CLASSA_HOST IN_CLASSA_MAX IN_CLASSA_NET
			       IN_CLASSA_NSHIFT IN_CLASSA_SUBHOST
			       IN_CLASSA_SUBNET IN_CLASSA_SUBNSHIFT
			       IN_CLASSB_HOST IN_CLASSB_MAX IN_CLASSB_NET
			       IN_CLASSB_NSHIFT IN_CLASSB_SUBHOST
			       IN_CLASSB_SUBNET IN_CLASSB_SUBNSHIFT
			       IN_CLASSC_HOST IN_CLASSC_MAX IN_CLASSC_NET
			       IN_CLASSC_NSHIFT
			       IN_CLASSD_HOST IN_CLASSD_NET IN_CLASSD_NSHIFT
			       IN_CLASSA IN_CLASSB IN_CLASSC IN_CLASSD
			       IPPORT_TIMESERVER
			       SUBNETSHIFT)],
	ALL		=> [@EXPORT, @EXPORT_OK],
    );

}

# sub AUTOLOAD inherited from Net::Gen

# inherited autoload for 'regular' subroutines is being removed in
# 5.003_96, so cheat a little.

sub AUTOLOAD
{
    $Net::Gen::AUTOLOAD = $AUTOLOAD;
    goto &Net::Gen::AUTOLOAD;
}

# Preloaded methods go here.  Autoload methods go after __END__, and are
# processed by the autosplit program.

my %sockopts;

%sockopts = (
	     # socket options from the list above
	     # simple booleans first

	     'IP_HDRINCL'	=> ['I'],
	     'IP_RECVDSTADDR'	=> ['I'],
	     'IP_RECVOPTS'	=> ['I'],
	     'IP_RECVRETOPTS'	=> ['I'],

	     # simple integer options

	     'IP_TOS'		=> ['I'],
	     'IP_TTL'		=> ['I'],

	     # structured options

	     'IP_ADD_MEMBERSHIP'=> ['a4a4'], # ip_mreq
	     'IP_DROP_MEMBERSHIP'=> ['a4a4'], # ip_mreq
	     'IP_MULTICAST_IF'	=> ['a4'], # inet_addr
	     'IP_MULTICAST_LOOP'=> ['C'], # u_char
	     'IP_MULTICAST_TTL'	=> ['C'], # u_char
	     'IP_OPTIONS'	=> ['a4C40'], # ip_options
	     'IP_RETOPTS'	=> ['a4C40'], # ip_options

	     # out of known IP options
	     );

__PACKAGE__->initsockopts( IPPROTO_IP(), \%sockopts );

#& htonl($number||@numbers) : $number || @numbers
sub htonl
{
    return unless defined wantarray;
    carp "Wrong number of arguments ($#_) to " . __PACKAGE__ . "::htonl, called"
	if @_ != 1 and !wantarray;
    unpack('N*', pack('L*', @_));
}

#& htons($number||@numbers) : $number || @numbers
sub htons
{
    return unless defined wantarray;
    carp "Wrong number of arguments ($#_) to " . __PACKAGE__ . "::htons, called"
	if @_ != 1 and !wantarray;
    unpack('n*', pack('S*', @_));
}

#& ntohl($number||@numbers) : $number || @numbers
sub ntohl
{
    return unless defined wantarray;
    carp "Wrong number of arguments ($#_) to " . __PACKAGE__ . "::ntohl, called"
	if @_ != 1 and !wantarray;
    unpack('L*', pack('N*', @_));
}

#& ntohs($number||@numbers) : $number || @numbers
sub ntohs
{
    return unless defined wantarray;
    carp "Wrong number of arguments ($#_) to " . __PACKAGE__ . "::ntohs, called"
	if @_ != 1 and !wantarray;
    unpack('S*', pack('n*', @_));
}

# removed inet_ntoa that was here -- the one in Socket is (now) good enough

#& pack_sockaddr_in([$family,] $port, $in_addr) : $packed_addr
sub pack_sockaddr_in ($$;$)
{
    unshift(@_,AF_INET) if @_ == 2;
    _pack_sockaddr_in($_[0], $_[1], $_[2]);
}

# sub unpack_sockaddr_in is in XS code


# Get the prototypes right for the autoloaded values, to avoid confusing
# the caller's code with changes in prototypes.

# sub inet_aton in Socket.xs

sub inet_addr;			# (helps with -w)
*inet_addr = \&inet_aton;	# same code for old interface


my $debug = 0;

#& _debug($this, [$newval]) : oldval
sub _debug : locked
{
    my ($this,$newval) = @_;
    return $this->debug($newval) if ref $this;
    my $prev = $debug;
    $debug = 0+$newval if defined $newval;
    $prev;
}

my %keyhandlers;
my @hostkeys = qw(thishost desthost);
@keyhandlers{@hostkeys} = (\&_sethost) x @hostkeys;
my @portkeys = qw(thisservice thisport destservice destport);
@keyhandlers{@portkeys} = (\&_setport) x @portkeys;
my @protokeys = qw(IPproto proto);
@keyhandlers{@protokeys} = (\&_setproto) x @protokeys;
# Don't include "handled" keys in this list, since that's redundant.
my @Keys = qw(lclhost lcladdr lclservice lclport
	      remhost remaddr remservice remport);

# leave these to be init'ed on the first new() call
my (%Keys,%Sopts);

#& new($class, [\%params]) : {$obj | undef}
sub new
{
    my $whoami = $_[0]->_trace(\@_,1);
    my($class,@Args,$self) = @_;
    $self = $class->SUPER::new(@Args);
    $class = ref $class if ref $class;
    $class->_trace(\@_,2,", self" .
		   (defined $self ? "=$self" : " undefined") .
		   " after sub-new");
    if ($self) {
	CORE::dump if $debug > 1 and
	    ref $self ne $class || "$self" !~ /HASH/;
	# init object debug level
	$self->setparams({'debug'=>$debug},-1);
	if (%Keys) {
	    $ {*$self}{Keys} = { %Keys } ;
	}
	else {
	    # register our keys and their handlers
	    $self->register_param_keys(\@Keys);
	    $self->register_param_handlers(\%keyhandlers);
	    %Keys = %{ $ {*$self}{Keys} } ;
	}
	if (%Sopts) {
	    $ {*$self}{Sockopts} = { %Sopts } ;
	}
	else {
	    # register our socket options
	    $self->register_options('IPPROTO_IP', IPPROTO_IP(), \%sockopts);
	    %Sopts = %{ $ {*$self}{Sockopts} } ;
	}
	# set our expected parameters
	$self->setparams({PF => PF_INET, AF => AF_INET},-1);
	if ($class eq __PACKAGE__) {
	    unless ($self->init(@Args)) {
		local $!;	# protect returned errno value
		undef $self;	# against close problems inside perl
		undef $self;	# another statement needed for sequencing
	    }
	}
	if ($self) {
	    $self->_trace(0,1," returning self=$self");
	}
	else {
	    $class->_trace(0,1," returning self=(undef)");
	}
    }
    else {
	$class->_trace(0,1," returning self=(undef)");
    }
    $self;
}

#& _hostport($self, {'this'|'dest'}, [\]@list) : boolean
sub _hostport
{
    my($self,$which,@args,$aref) = @_;
    $aref = \@args;		# assume in-line list unless proved otherwise
    $aref = $args[0] if @args == 1 && ref $args[0] && ref $args[0] eq 'ARRAY';
    return undef if $which ne 'dest' and $which ne 'this';
    if (@$aref) {		# assume this is ('desthost','destport')
	my %p;			# where we'll build the params list
	if (@$aref == 3 and ref($$aref[2]) and ref($$aref[2]) eq 'HASH') {
	    %p = %{$$aref[2]};
	}
	else {
	    %p = splice(@$aref,2); # assume valid params after
	}
	$p{"${which}host"} = $$aref[0] if defined $$aref[0];
	$p{"${which}port"} = $$aref[1] if defined $$aref[1];
	$self->setparams(\%p);
    }
    else {
	1;			# succeed vacuously if no work
    }
}

#& init($self, [\%params || @speclist]) : {$self | undef}
sub init : locked
{
    $_[0]->_trace(\@_,2);
    my($self,@args) = @_;
    return $self unless $self = $self->SUPER::init(@args);
    if (@args > 1 || @args == 1 && (!ref $args[0] || ref $args[0] ne 'HASH')) {
	return undef unless $self->_hostport('dest',@args);
    }
#   my @r;			# dummy array needed in 5.000
#   if ((@r=$self->getparams([qw(type proto)],1)) == 4) { # have type and proto
    if ($self->getparams([qw(type proto)],1) == 4) { # have type and proto
	unless ($self->open) {	# create the socket
	    return undef;	# and refuse to make less object than requested
	}
    }
    if ($self->getparam('srcaddrlist')) {
	# have enough object already to attempt the binding
	return undef unless $self->bind; # make no less object than requested
    }
    if ($self->getparam('dstaddrlist')) {
	# have enough object already to attempt the connection
	return undef unless $self->connect or
	    $self->isconnecting and !$self->blocking;
	# make no less object than requested
    }
    # I think this is all we need here ?
    $self;
}

#& connect($self, [\]@([host],[port])) : boolean
sub connect : locked method
{
    my($self,@args) = @_;
    return undef if @args and not $self->_hostport('dest',@args);
    $self->SUPER::connect;
}

#& _sethost($self,$key,$newval) : {'' | "carp string"}
sub _sethost
{
    my($self,$key,$newval) = @_;
    return "Invalid args to " . __PACKAGE__ . "::_sethost(@_), called"
	if @_ != 3 or ref($ {*$self}{Keys}{$key}) ne 'CODE';
    # check for call from delparams
    if (!defined $newval) {
	my @delkeys;
	if ($key eq 'thishost') {
	    @delkeys =
		qw(srcaddrlist srcaddr lclhost lcladdr lclport lclservice);
	}
	elsif ($key eq 'desthost') {
	    @delkeys =
		qw(dstaddrlist dstaddr remhost remaddr remport remservice);
	}
	splice(@delkeys, 1) if @delkeys and $self->isconnected;
	$self->delparams(\@delkeys) if @delkeys;
	return '';		# ok to delete
    }

    # here we're really trying to set some kind of address (we think)
    my ($pkey,$port);
    ($pkey = $key) =~ s/host$/port/;
    my (@addrs,$addr,$cport);
    ($newval,$cport) = ($1,$2) if
	$newval =~ m/^(.+):([-\w]+(?:\(\d+\))?)$/;
    if ($newval =~ m/^(\[?)([a-fx.\d]+)(\]?)$/si) {
	return "Invalid address literal $newval found"
	    if length($1) != length($3);
	$addr = inet_aton($2);
    }
    if (defined $addr and substr($newval, 0, 1) eq '[') {
	push(@addrs,$addr);
	$addr = '[' . inet_ntoa($addr) . ']';
    }
    else {
	my(@hinfo,$hname);
	$hname = $newval;
	do {
	    @hinfo = gethostbyname($hname);
	} while (!@hinfo && $hname =~ s/\.$//);
	if (!@hinfo and defined $addr) {
	    push(@addrs, $addr);
	    $addr = inet_ntoa($addr);
	}
	else {
	    return "Host $newval not found ($?)," unless @hinfo > 4;
	    return "Host $newval has strange address family ($hinfo[2]),"
		if $self->getparam('AF',AF_INET,1) != $hinfo[2];
	    @addrs = splice(@hinfo,4);
	    $addr = $hinfo[0];	# save canonical name for real setup
	    # just in case this is /etc/hosts or old sunos, try harder
	    if ($addr !~ /.\../ and $hinfo[1]) {
		for $hname (split(' ',$hinfo[1])) {
		    if ($hname =~ /.\../) {
			$addr = $hname;
			last;
		    }
		}
	    }
	}
    }
    # valid so far, get out if can't form addresses yet
    $port = $ {*$self}{Parms}{$pkey};
    return '' unless
	defined $cport or
	    defined $port or
		$pkey eq 'thisport'; # allow for 'bind'
    if (defined $cport) {
	return $newval if $newval = &_setport($self,$pkey,$cport);
	$port = $cport;
    }
    $port = 0 unless defined $port;
    my $af = $self->getparam('AF',AF_INET,1);
    for (@addrs) {
	$_ = pack_sockaddr_in($af, $port+0, $_);
    }
    $pkey = (($key eq 'desthost') ? 'dstaddrlist' : 'srcaddrlist');
    $self->setparams({$pkey => [@addrs]});
    # finally, we have validation
    $_[2] = $addr;		# update the canonical representation to store
    print STDERR " - " . __PACKAGE__ . "::_sethost $self $key ",
	$self->format_addr($addr,1),"\n"
	    if $ {*$self}{Parms}{'debug'};
    '';				# return nullstring for goodness
}

# These port assignments were generated from IANA's list of assigned ports
# as of 1997/05/17.

my %udp_ports;

my $udp_ports = "tcpmux	1
rje	5
echo	7
discard	9
null	9
sink	9
systat	11
daytime	13
netstat	15
qotd	17
quote	17
msp	18
chargen	19
source	19
ttytst	19
ftp-data	20
ftp	21
ssh	22
telnet	23
mail	25
smtp	25
nsw-fe	27
msg-icp	29
msg-auth	31
dsp	33
time	37
rap	38
rlp	39
graphics	41
name	42
nameserver	42
nicname	43
whois	43
mpm-flags	44
mpm	45
mpm-snd	46
ni-ftp	47
auditd	48
tacacs	49
re-mail-ck	50
la-maint	51
xns-time	52
dns	53
domain	53
xns-ch	54
isi-gl	55
xns-auth	56
xns-mail	58
ni-mail	61
acas	62
whois++	63
covia	64
tacacs-ds	65
sql*net	66
bootp	67
bootps	67
bootpc	68
tftp	69
gopher	70
netrjs-1	71
netrjs-2	72
netrjs-3	73
netrjs-4	74
deos	76
vettcp	78
finger	79
http	80
www	80
www-http	80
hosts2-ns	81
xfer	82
ctf	84
mfcobol	86
kerberos	88
su-mit-tg	89
dnsix	90
mit-dov	91
npp	92
dcp	93
objcall	94
supdup	95
dixie	96
swift-rvf	97
tacnews	98
metagram	99
hostname	101
hostnames	101
iso-tsap	102
gppitnp	103
acr-nema	104
csnet-ns	105
3com-tsmux	106
rtelnet	107
snagas	108
pop2	109
pop3	110
sunrpc	111
mcidas	112
auth	113
ident	113
audionews	114
sftp	115
ansanotify	116
uucp-path	117
sqlserv	118
nntp	119
untp	119
cfdptkt	120
erpc	121
smakynet	122
ntp	123
ansatrader	124
locus-map	125
unitary	126
locus-con	127
gss-xlicen	128
pwdgen	129
cisco-fna	130
cisco-tna	131
cisco-sys	132
statsrv	133
ingres-net	134
epmap	135
profile	136
netbios-ns	137
netbios-dgm	138
netbios-ssn	139
emfis-data	140
emfis-cntl	141
bl-idm	142
imap	143
news	144
uaac	145
iso-tp0	146
iso-ip	147
jargon	148
aed-512	149
sql-net	150
hems	151
bftp	152
sgmp	153
netsc-prod	154
netsc-dev	155
sqlsrv	156
knet-cmp	157
pcmail-srv	158
nss-routing	159
sgmp-traps	160
snmp	161
snmp-trap	162
snmptrap	162
cmip-man	163
smip-agent	164
xns-courier	165
s-net	166
namp	167
snmp-rt	167
rsvd	168
send	169
print-srv	170
multiplex	171
cl/1	172
xyplex-mux	173
mailq	174
vmnet	175
genrad-mux	176
xdmcp	177
nextstep	178
bgp	179
ris	180
unify	181
audit	182
ocbinder	183
ocserver	184
remote-kis	185
kis	186
aci	187
mumps	188
qft	189
cacp	190
gacp	190
prospero	191
osu-nms	192
srmp	193
irc	194
dn6-nlm-aud	195
dn6-smm-red	196
dlsold	197
dls-mon	198
smux	199
src	200
at-rtmp	201
at-nbp	202
at-3	203
at-echo	204
at-5	205
at-zis	206
at-7	207
at-8	208
qmtp	209
z39.50	210
914c/g	211
anet	212
ipx	213
vmpwscs	214
softpc	215
cailic	216
dbase	217
mpp	218
uarps	219
imap3	220
fln-spx	221
rsh-spx	222
cdc	223
direct	242
sur-meas	243
dayna	244
link	245
dsp3270	246
ibm-rap	256
set	257
yak-chat	258
esro-gen	259
openport	260
nsiiops	261
arcisdms	262
hdap	263
http-mgmt	280
personal-link	281
cableport-ax	282
entrusttime	309
pdap	344
pawserv	345
zserv	346
fatserv	347
csi-sgwp	348
matip-type-a	350
matip-type-b	351
dtag-ste-sb	352
clearcase	371
ulistproc	372
legent-1	373
legent-2	374
hassle	375
nip	376
tnetos	377
dsetos	378
is99c	379
is99s	380
hp-collector	381
hp-managed-node	382
hp-alarm-mgr	383
arns	384
ibm-app	385
asa	386
aurp	387
unidata-ldm	388
ldap	389
uis	390
synotics-relay	391
synotics-broker	392
dis	393
embl-ndt	394
netcp	395
netware-ip	396
mptn	397
kryptolan	398
iso-tsap-c2	399
work-sol	400
ups	401
genie	402
decap	403
nced	404
ncld	405
imsp	406
timbuktu	407
prm-sm	408
prm-nm	409
decladebug	410
rmt	411
synoptics-trap	412
smsp	413
infoseek	414
bnet	415
silverplatter	416
onmux	417
hyper-g	418
ariel1	419
smpte	420
ariel2	421
ariel3	422
opc-job-start	423
opc-job-track	424
icad-el	425
smartsdp	426
svrloc	427
ocs_cmu	428
ocs_amu	429
utmpsd	430
utmpcd	431
iasd	432
nnsp	433
mobileip-agent	434
mobilip-mn	435
dna-cml	436
comscm	437
dsfgw	438
dasp	439
sgcp	440
decvms-sysmgt	441
cvc_hostd	442
https	443
shttp	443
snpp	444
microsoft-ds	445
ddm-rdb	446
ddm-dfm	447
ddm-byte	448
as-servermap	449
tserver	450
sfs-smp-net	451
sfs-config	452
creativeserver	453
contentserver	454
creativepartnr	455
macon-udp	456
scohelp	457
appleqtc	458
ampr-rcmd	459
skronk	460
datarampsrv	461
datasurfsrv	461
datarampsrvsec	462
datasurfsrvsec	462
alpes	463
kpasswd	464
smtps	465
ssmtp	465
digital-vrc	466
mylex-mapd	467
photuris	468
rcp	469
scx-proxy	470
mondex	471
ljk-login	472
hybrid-pop	473
tn-tl-w2	474
tn-tl-fd1	476
ss7ns	477
spsc	478
iafserver	479
iafdbase	480
ph	481
bgs-nsi	482
ulpnet	483
integra-sme	484
powerburst	485
avian	486
saft	487
gss-http	488
nest-protocol	489
micom-pfs	490
go-login	491
ticf-1	492
ticf-2	493
pov-ray	494
intecourier	495
pim-rp-disc	496
dantz	497
siam	498
iso-ill	499
isakmp	500
stmf	501
asa-appl-proto	502
intrinsa	503
citadel	504
mailbox-lm	505
ohimsrv	506
crs	507
xvttp	508
snare	509
fcp	510
firstclass	510
mynet	511
mynet-as	511
biff	512
comsat	512
rwho	513
who	513
whod	513
syslog	514
printer	515
spooler	515
videotex	516
otalk	517
talk	517
ntalk	518
unixtime	519
utime	519
route	520
routed	520
router	520
ripng	521
ulp	522
ncp	524
timed	525
timeserver	525
newdate	526
tempo	526
stx	527
custix	528
courier	530
rpc	530
chat	531
conference	531
netnews	532
readnews	532
netwall	533
mm-admin	534
iiop	535
opalis-rdv	536
netmsp	537
gdomap	538
apertus-ldp	539
uucp	540
uucpd	540
uucp-rlogin	541
commerce	542
klogin	543
krcmd	544
kshell	544
appleqtcsrvr	545
dhcpv6-client	546
dhcpv6-server	547
afpovertcp	548
idfp	549
new-rwho	550
new-who	550
cybercash	551
deviceshare	552
pirp	553
rtsp	554
dsf	555
brfs	556
remotefs	556
rfs	556
rfs_server	556
openvms-sysipc	557
sdnskmp	558
teedtap	559
rmonitor	560
rmonitord	560
monitor	561
chcmd	562
chshell	562
nntps	563
snntp	563
9pfs	564
whoami	565
streettalk	566
banyan-rpc	567
ms-shuttle	568
ms-rome	569
demon	570
meter_demon	570
meterd	570
meter	571
udemon	571
sonar	572
banyan-vip	573
ftp-agent	574
vemmi	575
ipcd	576
vnas	577
ipdd	578
decbsrv	579
sntp-heartbeat	580
bdp	581
scc-security	582
philips-vc	583
keyserver	584
imap4-ssl	585
password-chg	586
submission	587
ipcserver	600
urm	606
nqs	607
sift-uft	608
npmp-trap	609
npmp-local	610
npmp-gui	611
hmmp-ind	612
hmmp-op	613
sshell	614
sslshell	614
sco-inetmgr	615
sco-sysmgr	616
sco-dtmgr	617
dei-icda	618
digital-evm	619
sco-websrvrmgr	620
escp-ip	621
servstat	633
ginad	634
rlzdbase	635
ldaps	636
sldap	636
lanserver	637
doom	666
mdqs	666
disclose	667
mecomm	668
meregister	669
vacdsm-sws	670
vacdsm-app	671
vpps-qua	672
cimplex	673
acap	674
elcsd	704
errlog	704
agentx	705
entrust-kmsh	709
entrust-ash	710
netviewdm1	729
netviewdm2	730
netviewdm3	731
netgw	741
netrcs	742
flexlm	744
fujitsu-dev	747
ris-cm	748
kerberos-adm	749
kerberos-iv	750
loadav	750
pump	751
qrh	752
rrh	753
tell	754
nlogin	758
con	759
ns	760
rxe	761
quotad	762
cycleserv	763
omserv	764
webster	765
phone	767
phonebook	767
vid	769
cadlock	770
rtip	771
cycleserv2	772
notify	773
acmaint_dbd	774
acmaint_transd	775
wpages	776
wpgs	780
concert	786
mdbs_daemon	800
device	801
iclcnet-locate	886
iclcnet_svinfo	887
accessbuilder	888
ftps-data	989
ftps	990
nas	991
stelnet	992
telnets	992
imap4s	993
imaps	993
simap4	993
ircs	994
sirc	994
pop3s	995
spop3	995
vsinet	996
maitrd	997
puparp	998
applix	999
puprouter	999
ock	1000
blackjack	1025
iad1	1030
iad2	1031
iad3	1032
neod1	1047
neod2	1048
nim	1058
nimreg	1059
instl_boots	1067
instl_bootc	1068
socks	1080
ansoft-lm-1	1083
ansoft-lm-2	1084
nfsd-keepalive	1110
lmsocialserver	1111
murray	1123
nfa	1155
mc-client	1180
lupa	1212
nerv	1222
hermes	1248
bmc-patroldb	1313
pdps	1314
vpjp	1345
alta-ana-lm	1346
bbn-mmc	1347
bbn-mmx	1348
sbook	1349
editbench	1350
equationbuilder	1351
lotusnote	1352
relief	1353
rightbrain	1354
edge	1355
intuitive	1355
intuitive-edge	1355
cuillamartin	1356
pegboard	1357
connlcli	1358
ftsrv	1359
mimer	1360
linx	1361
timeflies	1362
ndm-requester	1363
ndm-server	1364
adapt-sna	1365
netware-csp	1366
dcs	1367
screencast	1368
gv-us	1369
us-gv	1370
fc-cli	1371
fc-ser	1372
chromagrafx	1373
molly	1374
bytex	1375
ibm-pps	1376
cichlid	1377
elan	1378
dbreporter	1379
telesis-licman	1380
apple-licman	1381
gwha	1383
os-licman	1384
atex_elmd	1385
checksum	1386
cadsi-lm	1387
objective-dbc	1388
iclpv-dm	1389
iclpv-sc	1390
iclpv-sas	1391
iclpv-pm	1392
iclpv-nls	1393
iclpv-nlc	1394
iclpv-wsm	1395
dvl-activemail	1396
audio-activmail	1397
video-activmail	1398
cadkey-licman	1399
cadkey-tablet	1400
usim	1400
goldleaf-licman	1401
prm-sm-np	1402
prm-nm-np	1403
igi-lm	1404
ibm-res	1405
netlabs-lm	1406
dbsa-lm	1407
sophia-lm	1408
here-lm	1409
hiq	1410
af	1411
innosys	1412
innosys-acl	1413
ibm-mqseries	1414
dbstar	1415
novell-lu6.2	1416
timbuktu-srv2	1418
timbuktu-srv3	1419
timbuktu-srv4	1420
gandalf-lm	1421
autodesk-lm	1422
essbase	1423
hybrid	1424
zion-lm	1425
sais	1426
mloadd	1427
informatik-lm	1428
nms	1429
tpdu	1430
rgtp	1431
blueberry-lm	1432
ms-sql-s	1433
ms-sql-m	1434
ibm-cics	1435
saism	1436
tabula	1437
eicon-server	1438
eicon-x25	1439
eicon-slp	1440
cadis-1	1441
cadis-2	1442
ies-lm	1443
marcam-lm	1444
proxima-lm	1445
ora-lm	1446
apri-lm	1447
oc-lm	1448
peport	1449
dwf	1450
infoman	1451
gtegsc-lm	1452
genie-lm	1453
esl-lm	1455
dca	1456
valisys-lm	1457
nrcabq-lm	1458
proshare1	1459
proshare2	1460
ibm_wrless_lan	1461
world-lm	1462
nucleus	1463
msl_lmd	1464
pipes	1465
oceansoft-lm	1466
aal-lm	1469
uaiact	1470
csdmbase	1471
csdm	1472
openmath	1473
telefinder	1474
taligent-lm	1475
clvm-cfg	1476
ms-sna-server	1477
ms-sna-base	1478
dberegister	1479
pacerforum	1480
airs	1481
miteksys-lm	1482
afs	1483
confluent	1484
lansource	1485
nms_topo_serv	1486
localinfosrvr	1487
docstor	1488
dmdocbroker	1489
insitu-conf	1490
anynetgateway	1491
stone-design-1	1492
netmap_lm	1493
ica	1494
cvc	1495
liberty-lm	1496
rfx-lm	1497
watcom-sql	1498
fhc	1499
vlsi-lm	1500
saiscm	1501
shivadiscovery	1502
databeam	1503
imtc-mcs	1503
evb-elm	1504
funkproxy	1505
utcd	1506
symplex	1507
diagmond	1508
robcad-lm	1509
mvx-lm	1510
3l-l1	1511
wins	1512
fujitsu-dtc	1513
fujitsu-dtcns	1514
ifor-protocol	1515
vpad	1516
vpac	1517
vpvd	1518
vpvc	1519
atm-zip-office	1520
ncube-lm	1521
cichild-lm	1523
ingreslock	1524
orasrv	1525
prospero-np	1525
pdap-np	1526
tlisrv	1527
mciautoreg	1528
coauthor	1529
rap-service	1530
rap-listen	1531
miroconnect	1532
virtual-places	1533
micromuse-lm	1534
ampr-info	1535
ampr-inter	1536
sdsc-lm	1537
3ds-lm	1538
intellistor-lm	1539
rds	1540
rds2	1541
gridgen-elmd	1542
simba-cs	1543
aspeclmd	1544
vistium-share	1545
abbaccuray	1546
laplink	1547
axon-lm	1548
shivasound	1549
3m-image-lm	1550
hecmtl-db	1551
pciarray	1552
sna-cs	1553
caci-lm	1554
livelan	1555
ashwin	1556
arbortext-lm	1557
xingmpeg	1558
web2host	1559
asci-val	1560
facilityview	1561
pconnectmgr	1562
cadabra-lm	1563
pay-per-view	1564
windd	1565
winddlb	1565
corelvideo	1566
jlicelmd	1567
tsspmap	1568
ets	1569
orbixd	1570
rdb-dbs-disp	1571
chip-lm	1572
itscomm-ns	1573
mvel-lm	1574
oraclenames	1575
moldflow-lm	1576
hypercube-lm	1577
jacobus-lm	1578
tn-tl-r2	1580
vmf-msg-port	1581
msims	1582
simbaexpress	1583
tn-tl-fd2	1584
intv	1585
ibm-abtact	1586
pra_elmd	1587
triquest-lm	1588
vqp	1589
gemini-lm	1590
ncpm-pm	1591
commonspace	1592
mainsoft-lm	1593
sixtrak	1594
radio	1595
radio-bc	1596
orbplus-iiop	1597
picknfs	1598
simbaservices	1599
issd	1600
aas	1601
dec-inspect	1602
picodbc	1603
icabrowser	1604
slp	1605
slm-api	1606
stt	1607
smart-lm	1608
isysg-lm	1609
taurus-wh	1610
ill	1611
netbill-trans	1612
netbill-keyrep	1613
netbill-cred	1614
netbill-auth	1615
netbill-prod	1616
nimrod-agent	1617
skytelnet	1618
xs-openstorage	1619
faxportwinport	1620
softdataphone	1621
ontime	1622
jaleosnd	1623
udp-sr-port	1624
svs-omagent	1625
cncp	1636
cnap	1637
cnip	1638
cert-initiator	1639
cert-responder	1640
invision	1641
isis-am	1642
isis-ambc	1643
datametrics	1645
sa-msg-port	1646
rsap	1647
concurrent-lm	1648
inspect	1649
nkd	1650
shiva_confsrvr	1651
xnmp	1652
alphatech-lm	1653
stargatealerts	1654
dec-mbadmin	1655
dec-mbadmin-h	1656
fujitsu-mmpdc	1657
sixnetudr	1658
sg-lm	1659
skip-mc-gikreq	1660
netview-aix-1	1661
netview-aix-2	1662
netview-aix-3	1663
netview-aix-4	1664
netview-aix-5	1665
netview-aix-6	1666
netview-aix-7	1667
netview-aix-8	1668
netview-aix-9	1669
netview-aix-10	1670
netview-aix-11	1671
netview-aix-12	1672
proshare-mc-1	1673
proshare-mc-2	1674
pdp	1675
netcomm2	1676
groupwise	1677
prolink	1678
darcorp-lm	1679
microcom-sbp	1680
sd-elmd	1681
lanyon-lantern	1682
ncpm-hip	1683
snaresecure	1684
n2nremote	1685
cvmon	1686
nsjtp-ctrl	1687
nsjtp-data	1688
firefox	1689
ng-umds	1690
empire-empuma	1691
sstsys-lm	1692
rrirtr	1693
rrimwm	1694
rrilwm	1695
rrifmm	1696
rrisat	1697
rsvp-encap-1	1698
rsvp-encap-2	1699
mps-raft	1700
l2f	1701
deskshare	1702
hb-engine	1703
bcs-broker	1704
slingshot	1705
jetform	1706
vdmplay	1707
gat-lmd	1708
centra	1709
impera	1710
pptconference	1711
registrar	1712
conferencetalk	1713
sesi-lm	1714
houdini-lm	1715
xmsg	1716
fj-hdnet	1717
h323gatedisc	1718
h323gatestat	1719
h323hostcall	1720
caicci	1721
hks-lm	1722
pptp	1723
csbphonemaster	1724
iden-ralp	1725
winddx	1727
telindus	1728
citynl	1729
roketz	1730
msiccp	1731
proxim	1732
sipat	1733
cambertx-lm	1734
privatechat	1735
street-stream	1736
ultimad	1737
gamegen1	1738
webaccess	1739
encore	1740
cisco-net-mgmt	1741
3com-nsd	1742
cinegrfx-lm	1743
ncpm-ft	1744
remote-winsock	1745
ftrapid-1	1746
ftrapid-2	1747
oracle-em1	1748
aspen-services	1749
sslp	1750
swiftnet	1751
lofr-lm	1752
translogic-lm	1753
oracle-em2	1754
ms-streaming	1755
capfast-lmd	1756
cnhrp	1757
tftp-mcast	1758
spss-lm	1759
www-ldap-gw	1760
cft-0	1761
cft-1	1762
cft-2	1763
cft-3	1764
cft-4	1765
cft-5	1766
cft-6	1767
cft-7	1768
bmc-net-adm	1769
bmc-net-svc	1770
vaultbase	1771
essweb-gw	1772
kmscontrol	1773
global-dtserv	1774
femis	1776
powerguardian	1777
prodigy-internet	1778
pharmasoft	1779
dpkeyserv	1780
answersoft-lm	1781
hp-hcip	1782
fjris	1783
finle-lm	1784
windlm	1785
funk-logger	1786
funk-license	1787
psmond	1788
hello	1789
nmsp	1790
ea1	1791
ibm-dt-2	1792
rsc-robot	1793
cera-bcm	1794
dpi-proxy	1795
vocaltec-admin	1796
uma	1797
etp	1798
netrisk	1799
ansys-lm	1800
msmq	1801
concomp1	1802
hp-hcip-gwy	1803
enl	1804
enl-name	1805
musiconline	1806
fhsp	1807
oracle-vp2	1808
oracle-vp1	1809
jerand-lm	1810
scientia-sdb	1811
radius	1812
radius-acct	1813
tdp-suite	1814
mmpft	1815
etftp	1818
plato-lm	1819
mcagent	1820
donnyworld	1821
es-elmd	1822
unisys-lm	1823
metrics-pas	1824
fjicl-tep-a	1901
fjicl-tep-b	1902
linkname	1903
fjicl-tep-c	1904
sugp	1905
tpmd	1906
tportmapperreq	1906
intrastar	1907
dawn	1908
global-wlink	1909
armadp	1913
elm-momentum	1914
facelink	1915
persoft	1916
noagent	1917
can-nds	1918
can-dch	1919
can-ferret	1920
close-combat	1944
dialogic-elmd	1945
tekpls	1946
eye2eye	1948
ismaeasdaqlive	1949
ismaeasdaqtest	1950
bcs-lmserver	1951
dlsrap	1973
foliocorp	1985
licensedaemon	1986
tr-rsrb-p1	1987
tr-rsrb-p2	1988
mshnet	1989
tr-rsrb-p3	1989
stun-p1	1990
stun-p2	1991
ipsendmsg	1992
stun-p3	1992
snmp-tcp-port	1993
stun-port	1994
perf-port	1995
tr-rsrb-port	1996
gdp-port	1997
x25-svc-port	1998
tcp-id-port	1999
callbook	2000
curry	2001
wizard	2001
globe	2002
emce	2004
oracle	2005
raid	2006
raid-cc	2006
raid-am	2007
terminaldb	2008
whosockami	2009
pipe_server	2010
servserv	2011
raid-ac	2012
raid-cd	2013
raid-sf	2014
raid-cs	2015
bootserver	2016
bootclient	2017
rellpack	2018
about	2019
xinupageserver	2020
xinuexpansion1	2021
xinuexpansion2	2022
xinuexpansion3	2023
xinuexpansion4	2024
xribs	2025
scrabble	2026
shadowserver	2027
submitserver	2028
device2	2030
blackboard	2032
glogger	2033
scoremgr	2034
imsldoc	2035
objectmanager	2038
lam	2040
interbase	2041
isis	2042
isis-bcast	2043
rimsl	2044
cdfunc	2045
sdfunc	2046
dls	2047
dls-monitor	2048
nfs	2049
shilp	2049
dlsrpn	2065
dlswpn	2067
zephyr-srv	2102
zephyr-clt	2103
zephyr-hm	2104
minipay	2105
mc-gt-srv	2180
ats	2201
imtc-map	2202
kali	2213
unreg-ab1	2221
unreg-ab2	2222
inreg-ab3	2223
ivs-video	2232
infocrypt	2233
directplay	2234
sercomm-wlink	2235
nani	2236
optech-port1-lm	2237
aviva-sna	2238
imagequery	2239
ivsd	2241
xmquery	2279
lnvpoller	2280
lnvconsole	2281
lnvalarm	2282
lnvstatus	2283
lnvmaps	2284
lnvmailmon	2285
nas-metering	2286
dna	2287
netml	2288
pehelp	2307
sdhelp	2308
cvspserver	2401
rtsserv	2500
rtsclient	2501
netrek	2592
tqdata	2700
www-dev	2784
aic-np	2785
aic-oncrpc	2786
piccolo	2787
fryeserv	2788
media-agent	2789
mao	2908
funk-dialout	2909
tdaccess	2910
blockade	2911
epicon	2912
hbci	3000
redwood-broker	3001
exlm-agent	3002
ping-pong	3010
trusted-web	3011
hlserver	3047
pctrader	3048
nsws	3049
vmodem	3141
rdc-wh-eos	3142
seaview	3143
tarantella	3144
csi-lfap	3145
mc-brk-srv	3180
ccmail	3264
altav-tunnel	3265
ns-cfg-server	3266
ibm-dial-out	3267
msft-gc	3268
msft-gc-ssl	3269
verismart	3270
csoft-prev	3271
user-manager	3272
sxmp	3273
ordinox-server	3274
samd	3275
maxim-asics	3276
dec-notes	3333
bmap	3421
prsvp	3455
vat	3456
vat-control	3457
d3winosfi	3458
integral	3459
udt_os	3900
mapper-nodemgr	3984
mapper-mapethd	3985
mapper-ws_ethd	3986
terabase	4000
netcheque	4008
chimera-hwm	4009
samsung-unidex	4010
altserviceboot	4011
pda-gate	4012
acl-manager	4013
nuts_dem	4132
nuts_bootp	4133
nifty-hmi	4134
oirtgsvc	4141
oidocsvc	4142
oidsr	4143
rwhois	4321
unicall	4343
vinainstall	4344
krb524	4444
nv-video	4444
upnotifyp	4445
n1-fwp	4446
n1-rmgmt	4447
asc-slmd	4448
arcryptoip	4449
camp	4450
ctisystemmsg	4451
ctiprogramload	4452
nssalertmgr	4453
nssagentmgr	4454
sae-urn	4500
urn-x-cdchoice	4501
rfa	4672
commplex-main	5000
commplex-link	5001
rfe	5002
claris-fmpro	5003
avt-profile-1	5004
avt-profile-2	5005
telelpathstart	5010
telelpathattack	5011
zenginkyo-1	5020
zenginkyo-2	5021
mmcc	5050
rmonitor_secure	5145
atmp	5150
aol	5190
aol-1	5191
aol-2	5192
aol-3	5193
padl2sim	5236
hacl-hb	5300
hacl-gs	5301
hacl-cfg	5302
hacl-probe	5303
hacl-local	5304
hacl-test	5305
sun-mc-grp	5306
sco-aip	5307
cfengine	5308
jprinter	5309
outlaws	5310
tmlogin	5311
excerpt	5400
excerpts	5401
mftp	5402
hpoms-ci-lstn	5403
hpoms-dps-lstn	5404
netsupport	5405
systemics-sox	5406
foresyte-clear	5407
foresyte-sec	5408
salient-dtasrv	5409
salient-usrmgr	5410
actnet	5411
continuus	5412
wwiotalk	5413
statusd	5414
ns-server	5415
sns-gateway	5416
sns-agent	5417
mcntp	5418
dj-ice	5419
cylink-c	5420
personal-agent	5555
esmmanager	5600
esmagent	5601
a1-msc	5602
a1-bs	5603
a3-sdunode	5604
a4-sdunode	5605
pcanywheredata	5631
pcanywherestat	5632
rrac	5678
dccm	5679
proshareaudio	5713
prosharevideo	5714
prosharedata	5715
prosharerequest	5716
prosharenotify	5717
openmail	5729
fcopy-server	5745
openmailg	5755
x500ms	5757
openmailns	5766
s-openmail	5767
x11	6000
softcm	6110
spc	6111
dtspcd	6112
backup-express	6123
meta-corp	6141
aspentec-lm	6142
watershed-lm	6143
statsci1-lm	6144
statsci2-lm	6145
lonewolf-lm	6146
montage-lm	6147
tal-pod	6149
crip	6253
clariion-evr01	6389
lvision-lm	6471
xdsxdm	6558
vocaltec-gold	6670
vision_server	6672
vision_elmd	6673
ambit-lm	6831
acmsoda	6969
afs3-fileserver	7000
afs3-callback	7001
afs3-prserver	7002
afs3-vlserver	7003
afs3-kaserver	7004
afs3-volser	7005
afs3-errors	7006
afs3-bos	7007
afs3-update	7008
afs3-rmtsys	7009
ups-onlinet	7010
lazy-ptop	7099
font-service	7100
fodms	7200
dlip	7201
winqedit	7395
pmdmgr	7426
oveadmgr	7427
ovladmgr	7428
opi-sock	7429
xmpv7	7430
pmd	7431
telops-lmd	7491
pafec-lm	7511
cbt	7777
accu-lmgr	7781
quest-vista	7980
irdmi2	7999
irdmi	8000
pro-ed	8032
npmp	8450
ddi-udp-1	8888
ddi-udp-2	8889
ddi-udp-3	8890
ddi-udp-4	8891
ddi-udp-5	8892
ddi-udp-6	8893
ddi-udp-7	8894
cslistener	9000
man	9535
sd	9876
distinct32	9998
distinct	9999
ndmp	10000
tsaf	12753
dsmcc-config	13818
dsmcc-session	13819
dsmcc-passthru	13820
dsmcc-download	13821
dsmcc-ccp	13822
isode-dua	17007
biimenu	18000
webphone	21845
netspeak-is	21846
netspeak-cs	21847
netspeak-acd	21848
netspeak-cps	21849
wnn6	22273
vocaltec-phone	22555
aws-brf	22800
brf-gw	22951
icl-twobase1	25000
icl-twobase2	25001
icl-twobase3	25002
icl-twobase4	25003
icl-twobase5	25004
icl-twobase6	25005
icl-twobase7	25006
icl-twobase8	25007
icl-twobase9	25008
icl-twobase10	25009
vocaltec-hos	25793
wnn6-ds	26208
dbbrowse	47557
alc	47806
ap	47806
bacnet	47808
";

my %tcp_ports;

my $tcp_ports = "tcpmux	1
rje	5
echo	7
discard	9
null	9
sink	9
systat	11
daytime	13
netstat	15
qotd	17
quote	17
msp	18
chargen	19
source	19
ttytst	19
ftp-data	20
ftp	21
ssh	22
telnet	23
mail	25
smtp	25
nsw-fe	27
msg-icp	29
msg-auth	31
dsp	33
time	37
rap	38
rlp	39
graphics	41
name	42
nameserver	42
nicname	43
whois	43
mpm-flags	44
mpm	45
mpm-snd	46
ni-ftp	47
auditd	48
tacacs	49
re-mail-ck	50
la-maint	51
xns-time	52
dns	53
domain	53
xns-ch	54
isi-gl	55
xns-auth	56
xns-mail	58
ni-mail	61
acas	62
whois++	63
covia	64
tacacs-ds	65
sql*net	66
bootp	67
bootps	67
bootpc	68
tftp	69
gopher	70
netrjs-1	71
netrjs-2	72
netrjs-3	73
netrjs-4	74
deos	76
vettcp	78
finger	79
http	80
www	80
www-http	80
hosts2-ns	81
xfer	82
ctf	84
mfcobol	86
kerberos	88
su-mit-tg	89
dnsix	90
mit-dov	91
npp	92
dcp	93
objcall	94
supdup	95
dixie	96
swift-rvf	97
tacnews	98
metagram	99
newacct	100
hostname	101
hostnames	101
iso-tsap	102
gppitnp	103
acr-nema	104
csnet-ns	105
cso	105
3com-tsmux	106
rtelnet	107
snagas	108
pop2	109
pop3	110
sunrpc	111
mcidas	112
auth	113
ident	113
audionews	114
sftp	115
ansanotify	116
uucp-path	117
sqlserv	118
nntp	119
cfdptkt	120
erpc	121
smakynet	122
ntp	123
ansatrader	124
locus-map	125
unitary	126
locus-con	127
gss-xlicen	128
pwdgen	129
cisco-fna	130
cisco-tna	131
cisco-sys	132
statsrv	133
ingres-net	134
epmap	135
profile	136
netbios-ns	137
netbios-dgm	138
netbios-ssn	139
emfis-data	140
emfis-cntl	141
bl-idm	142
imap	143
news	144
uaac	145
iso-tp0	146
iso-ip	147
jargon	148
aed-512	149
sql-net	150
hems	151
bftp	152
sgmp	153
netsc-prod	154
netsc-dev	155
sqlsrv	156
knet-cmp	157
pcmail-srv	158
nss-routing	159
sgmp-traps	160
snmp	161
snmptrap	162
cmip-man	163
cmip-agent	164
xns-courier	165
s-net	166
namp	167
rsvd	168
send	169
print-srv	170
multiplex	171
cl/1	172
xyplex-mux	173
mailq	174
vmnet	175
genrad-mux	176
xdmcp	177
nextstep	178
bgp	179
ris	180
unify	181
audit	182
ocbinder	183
ocserver	184
remote-kis	185
kis	186
aci	187
mumps	188
qft	189
gacp	190
prospero	191
osu-nms	192
srmp	193
irc	194
dn6-nlm-aud	195
dn6-smm-red	196
dlsold	197
dls-mon	198
smux	199
src	200
at-rtmp	201
at-nbp	202
at-3	203
at-echo	204
at-5	205
at-zis	206
at-7	207
at-8	208
qmtp	209
z39.50	210
914c/g	211
anet	212
ipx	213
vmpwscs	214
softpc	215
cailic	216
dbase	217
mpp	218
uarps	219
imap3	220
fln-spx	221
rsh-spx	222
cdc	223
direct	242
sur-meas	243
dayna	244
link	245
dsp3270	246
ibm-rap	256
set	257
yak-chat	258
esro-gen	259
openport	260
nsiiops	261
arcisdms	262
hdap	263
http-mgmt	280
personal-link	281
cableport-ax	282
entrusttime	309
pdap	344
pawserv	345
zserv	346
fatserv	347
csi-sgwp	348
matip-type-a	350
matip-type-b	351
dtag-ste-sb	352
clearcase	371
ulistproc	372
legent-1	373
legent-2	374
hassle	375
nip	376
tnetos	377
dsetos	378
is99c	379
is99s	380
hp-collector	381
hp-managed-node	382
hp-alarm-mgr	383
arns	384
ibm-app	385
asa	386
aurp	387
unidata-ldm	388
ldap	389
uis	390
synotics-relay	391
synotics-broker	392
dis	393
embl-ndt	394
netcp	395
netware-ip	396
mptn	397
kryptolan	398
iso-tsap-c2	399
work-sol	400
ups	401
genie	402
decap	403
nced	404
ncld	405
imsp	406
timbuktu	407
prm-sm	408
prm-nm	409
decladebug	410
rmt	411
synoptics-trap	412
smsp	413
infoseek	414
bnet	415
silverplatter	416
onmux	417
hyper-g	418
ariel1	419
smpte	420
ariel2	421
ariel3	422
opc-job-start	423
opc-job-track	424
icad-el	425
smartsdp	426
svrloc	427
ocs_cmu	428
ocs_amu	429
utmpsd	430
utmpcd	431
iasd	432
nnsp	433
mobileip-agent	434
mobilip-mn	435
dna-cml	436
comscm	437
dsfgw	438
dasp	439
sgcp	440
decvms-sysmgt	441
cvc_hostd	442
https	443
shttp	443
snpp	444
microsoft-ds	445
ddm-rdb	446
ddm-dfm	447
ddm-rfm	447
ddm-byte	448
as-servermap	449
tserver	450
sfs-smp-net	451
sfs-config	452
creativeserver	453
contentserver	454
creativepartnr	455
macon-tcp	456
scohelp	457
appleqtc	458
ampr-rcmd	459
skronk	460
datarampsrv	461
datasurfsrv	461
datarampsrvsec	462
datasurfsrvsec	462
alpes	463
kpasswd	464
smtps	465
ssmtp	465
digital-vrc	466
mylex-mapd	467
photuris	468
rcp	469
scx-proxy	470
mondex	471
ljk-login	472
hybrid-pop	473
tn-tl-w1	474
tcpnethaspsrv	475
tn-tl-fd1	476
ss7ns	477
spsc	478
iafserver	479
iafdbase	480
ph	481
bgs-nsi	482
ulpnet	483
integra-sme	484
powerburst	485
avian	486
saft	487
gss-http	488
nest-protocol	489
micom-pfs	490
go-login	491
ticf-1	492
ticf-2	493
pov-ray	494
intecourier	495
pim-rp-disc	496
dantz	497
siam	498
iso-ill	499
isakmp	500
stmf	501
asa-appl-proto	502
intrinsa	503
citadel	504
mailbox-lm	505
ohimsrv	506
crs	507
xvttp	508
snare	509
fcp	510
firstclass	510
mynet	511
mynet-as	511
exec	512
login	513
cmd	514
rcmd	514
shell	514
printer	515
spooler	515
videotex	516
otalk	517
talk	517
ntalk	518
unixtime	519
utime	519
efs	520
ripng	521
ulp	522
ibm-db2	523
ncp	524
timed	525
timeserver	525
newdate	526
tempo	526
stx	527
custix	528
irc-serv	529
courier	530
rpc	530
chat	531
conference	531
netnews	532
readnews	532
netwall	533
mm-admin	534
iiop	535
opalis-rdv	536
netmsp	537
gdomap	538
apertus-ldp	539
uucp	540
uucpd	540
uucp-rlogin	541
commerce	542
klogin	543
krcmd	544
kshell	544
appleqtcsrvr	545
dhcpv6-client	546
dhcpv6-server	547
afpovertcp	548
idfp	549
new-rwho	550
new-who	550
cybercash	551
deviceshare	552
pirp	553
rtsp	554
dsf	555
brfs	556
remotefs	556
rfs	556
rfs_server	556
openvms-sysipc	557
sdnskmp	558
teedtap	559
rmonitor	560
rmonitord	560
monitor	561
chcmd	562
chshell	562
nntps	563
snntp	563
9pfs	564
whoami	565
streettalk	566
banyan-rpc	567
ms-shuttle	568
ms-rome	569
demon	570
meterd	570
meter	571
udemon	571
sonar	572
banyan-vip	573
ftp-agent	574
vemmi	575
ipcd	576
vnas	577
ipdd	578
decbsrv	579
sntp-heartbeat	580
bdp	581
scc-security	582
philips-vc	583
keyserver	584
imap4-ssl	585
password-chg	586
submission	587
ipcserver	600
urm	606
nqs	607
sift-uft	608
npmp-trap	609
npmp-local	610
npmp-gui	611
hmmp-ind	612
hmmp-op	613
sshell	614
sslshell	614
sco-inetmgr	615
sco-sysmgr	616
sco-dtmgr	617
dei-icda	618
digital-evm	619
sco-websrvrmgr	620
escp	621
escp-ip	621
servstat	633
ginad	634
rlzdbase	635
ldaps	636
sldap	636
lanserver	637
doom	666
mdqs	666
disclose	667
mecomm	668
meregister	669
vacdsm-sws	670
vacdsm-app	671
vpps-qua	672
cimplex	673
acap	674
elcsd	704
errlog	704
agentx	705
entrust-kmsh	709
entrust-ash	710
netviewdm1	729
netviewdm2	730
netviewdm3	731
netgw	741
netrcs	742
flexlm	744
fujitsu-dev	747
ris-cm	748
kerberos-adm	749
rfile	750
pump	751
qrh	752
rrh	753
tell	754
nlogin	758
con	759
ns	760
rxe	761
quotad	762
cycleserv	763
omserv	764
webster	765
phone	767
phonebook	767
vid	769
cadlock	770
rtip	771
cycleserv2	772
submit	773
rpasswd	774
entomb	775
wpages	776
wpgs	780
concert	786
mdbs_daemon	800
device	801
iclcnet-locate	886
iclcnet_svinfo	887
accessbuilder	888
xact-backup	911
ftps-data	989
ftps	990
nas	991
telnets	992
imaps	993
ircs	994
pop3s	995
spop3	995
vsinet	996
maitrd	997
busboy	998
garcon	999
puprouter	999
ock	1000
blackjack	1025
iad1	1030
iad2	1031
iad3	1032
neod1	1047
neod2	1048
nim	1058
nimreg	1059
instl_boots	1067
instl_bootc	1068
socks	1080
ansoft-lm-1	1083
ansoft-lm-2	1084
nfsd-status	1110
lmsocialserver	1111
murray	1123
nfa	1155
mc-client	1180
lupa	1212
nerv	1222
hermes	1248
bmc_patroldb	1313
pdps	1314
vpjp	1345
alta-ana-lm	1346
bbn-mmc	1347
bbn-mmx	1348
sbook	1349
editbench	1350
equationbuilder	1351
lotusnote	1352
relief	1353
rightbrain	1354
edge	1355
intuitive	1355
intuitive-edge	1355
cuillamartin	1356
pegboard	1357
connlcli	1358
ftsrv	1359
mimer	1360
linx	1361
timeflies	1362
ndm-requester	1363
ndm-server	1364
adapt-sna	1365
netware-csp	1366
dcs	1367
screencast	1368
gv-us	1369
us-gv	1370
fc-cli	1371
fc-ser	1372
chromagrafx	1373
molly	1374
bytex	1375
ibm-pps	1376
cichlid	1377
elan	1378
dbreporter	1379
telesis-licman	1380
apple-licman	1381
gwha	1383
os-licman	1384
atex_elmd	1385
checksum	1386
cadsi-lm	1387
objective-dbc	1388
iclpv-dm	1389
iclpv-sc	1390
iclpv-sas	1391
iclpv-pm	1392
iclpv-nls	1393
iclpv-nlc	1394
iclpv-wsm	1395
dvl-activemail	1396
audio-activmail	1397
video-activmail	1398
cadkey-licman	1399
cadkey-tablet	1400
goldleaf-licman	1401
prm-sm-np	1402
prm-nm-np	1403
igi-lm	1404
ibm-res	1405
netlabs-lm	1406
dbsa-lm	1407
sophia-lm	1408
here-lm	1409
hiq	1410
af	1411
innosys	1412
innosys-acl	1413
ibm-mqseries	1414
dbstar	1415
novell-lu6.2	1416
timbuktu-srv1	1417
timbuktu-srv2	1418
timbuktu-srv3	1419
timbuktu-srv4	1420
gandalf-lm	1421
autodesk-lm	1422
essbase	1423
hybrid	1424
zion-lm	1425
sais	1426
mloadd	1427
informatik-lm	1428
nms	1429
tpdu	1430
rgtp	1431
blueberry-lm	1432
ms-sql-s	1433
ms-sql-m	1434
ibm-cics	1435
saism	1436
tabula	1437
eicon-server	1438
eicon-x25	1439
eicon-slp	1440
cadis-1	1441
cadis-2	1442
ies-lm	1443
marcam-lm	1444
proxima-lm	1445
ora-lm	1446
apri-lm	1447
oc-lm	1448
peport	1449
dwf	1450
infoman	1451
gtegsc-lm	1452
genie-lm	1453
interhdl_elmd	1454
esl-lm	1455
dca	1456
valisys-lm	1457
nrcabq-lm	1458
proshare1	1459
proshare2	1460
ibm_wrless_lan	1461
world-lm	1462
nucleus	1463
msl_lmd	1464
pipes	1465
oceansoft-lm	1466
aal-lm	1469
uaiact	1470
csdmbase	1471
csdm	1472
openmath	1473
telefinder	1474
taligent-lm	1475
clvm-cfg	1476
ms-sna-server	1477
ms-sna-base	1478
dberegister	1479
pacerforum	1480
airs	1481
miteksys-lm	1482
afs	1483
confluent	1484
lansource	1485
nms_topo_serv	1486
localinfosrvr	1487
docstor	1488
dmdocbroker	1489
insitu-conf	1490
anynetgateway	1491
stone-design-1	1492
netmap_lm	1493
ica	1494
cvc	1495
liberty-lm	1496
rfx-lm	1497
watcom-sql	1498
fhc	1499
vlsi-lm	1500
saiscm	1501
shiva	1502
shivadiscovery	1502
databeam	1503
imtc-mcs	1503
evb-elm	1504
funkproxy	1505
utcd	1506
symplex	1507
diagmond	1508
robcad-lm	1509
mvx-lm	1510
3l-l1	1511
wins	1512
fujitsu-dtc	1513
fujitsu-dtcns	1514
ifor-protocol	1515
vpad	1516
vpac	1517
vpvd	1518
vpvc	1519
atm-zip-office	1520
ncube-lm	1521
cichild	1523
cichild-lm	1523
ingres	1524
ingreslock	1524
orasrv	1525
prospero-np	1525
pdap-np	1526
tlisrv	1527
mciautoreg	1528
coauthor	1529
rap-service	1530
rap-listen	1531
miroconnect	1532
virtual-places	1533
micromuse-lm	1534
ampr-info	1535
ampr-inter	1536
sdsc-lm	1537
3ds-lm	1538
intellistor-lm	1539
rds	1540
rds2	1541
gridgen-elmd	1542
simba-cs	1543
aspeclmd	1544
vistium-share	1545
abbaccuray	1546
laplink	1547
axon-lm	1548
shivahose	1549
3m-image-lm	1550
hecmtl-db	1551
pciarray	1552
sna-cs	1553
caci-lm	1554
livelan	1555
ashwin	1556
arbortext-lm	1557
xingmpeg	1558
web2host	1559
asci-val	1560
facilityview	1561
pconnectmgr	1562
cadabra-lm	1563
pay-per-view	1564
windd	1565
winddlb	1565
corelvideo	1566
jlicelmd	1567
tsspmap	1568
ets	1569
orbixd	1570
rdb-dbs-disp	1571
chip-lm	1572
itscomm-ns	1573
mvel-lm	1574
oraclenames	1575
moldflow-lm	1576
hypercube-lm	1577
jacobus-lm	1578
ioc-sea-lm	1579
tn-tl-r1	1580
vmf-msg-port	1581
msims	1582
simbaexpress	1583
tn-tl-fd2	1584
intv	1585
ibm-abtact	1586
pra_elmd	1587
triquest-lm	1588
vqp	1589
gemini-lm	1590
ncpm-pm	1591
commonspace	1592
mainsoft-lm	1593
sixtrak	1594
radio	1595
radio-sm	1596
orbplus-iiop	1597
picknfs	1598
simbaservices	1599
issd	1600
aas	1601
dec-inspect	1602
pickodbc	1603
picodbc	1603
icabrowser	1604
slp	1605
slm-api	1606
stt	1607
smart-lm	1608
isysg-lm	1609
taurus-wh	1610
ill	1611
netbill-trans	1612
netbill-keyrep	1613
netbill-cred	1614
netbill-auth	1615
netbill-prod	1616
nimrod-agent	1617
skytelnet	1618
xs-openstorage	1619
faxportwinport	1620
softdataphone	1621
ontime	1622
jaleosnd	1623
udp-sr-port	1624
svs-omagent	1625
cncp	1636
cnap	1637
cnip	1638
cert-initiator	1639
cert-responder	1640
invision	1641
isis-am	1642
isis-ambc	1643
saiseh	1644
datametrics	1645
sa-msg-port	1646
rsap	1647
concurrent-lm	1648
inspect	1649
nkd	1650
shiva_confsrvr	1651
xnmp	1652
alphatech-lm	1653
stargatealerts	1654
dec-mbadmin	1655
dec-mbadmin-h	1656
fujitsu-mmpdc	1657
sixnetudr	1658
sg-lm	1659
skip-mc-gikreq	1660
netview-aix-1	1661
netview-aix-2	1662
netview-aix-3	1663
netview-aix-4	1664
netview-aix-5	1665
netview-aix-6	1666
netview-aix-7	1667
netview-aix-8	1668
netview-aix-9	1669
netview-aix-10	1670
netview-aix-11	1671
netview-aix-12	1672
proshare-mc-1	1673
proshare-mc-2	1674
pdp	1675
netcomm1	1676
groupwise	1677
prolink	1678
darcorp-lm	1679
microcom-sbp	1680
sd-elmd	1681
lanyon-lantern	1682
ncpm-hip	1683
snaresecure	1684
n2nremote	1685
cvmon	1686
nsjtp-ctrl	1687
nsjtp-data	1688
firefox	1689
ng-umds	1690
empire-empuma	1691
sstsys-lm	1692
rrirtr	1693
rrimwm	1694
rrilwm	1695
rrifmm	1696
rrisat	1697
rsvp-encap-1	1698
rsvp-encapsulation-1	1698
rsvp-encap-2	1699
rsvp-encapsulation-2	1699
mps-raft	1700
l2f	1701
deskshare	1702
hb-engine	1703
bcs-broker	1704
slingshot	1705
jetform	1706
vdmplay	1707
gat-lmd	1708
centra	1709
impera	1710
pptconference	1711
registrar	1712
conferencetalk	1713
sesi-lm	1714
houdini-lm	1715
xmsg	1716
fj-hdnet	1717
h323gatedisc	1718
h323gatestat	1719
h323hostcall	1720
caicci	1721
hks-lm	1722
pptp	1723
csbphonemaster	1724
iden-ralp	1725
iberiagames	1726
winddx	1727
telindus	1728
citynl	1729
roketz	1730
msiccp	1731
proxim	1732
sipat	1733
cambertx-lm	1734
privatechat	1735
street-stream	1736
ultimad	1737
gamegen1	1738
webaccess	1739
encore	1740
cisco-net-mgmt	1741
3com-nsd	1742
cinegrfx-lm	1743
ncpm-ft	1744
remote-winsock	1745
ftrapid-1	1746
ftrapid-2	1747
oracle-em1	1748
aspen-services	1749
sslp	1750
swiftnet	1751
lofr-lm	1752
translogic-lm	1753
oracle-em2	1754
ms-streaming	1755
capfast-lmd	1756
cnhrp	1757
tftp-mcast	1758
spss-lm	1759
www-ldap-gw	1760
cft-0	1761
cft-1	1762
cft-2	1763
cft-3	1764
cft-4	1765
cft-5	1766
cft-6	1767
cft-7	1768
bmc-net-adm	1769
bmc-net-svc	1770
vaultbase	1771
essweb-gw	1772
kmscontrol	1773
global-dtserv	1774
femis	1776
powerguardian	1777
prodigy-internet	1778
pharmasoft	1779
dpkeyserv	1780
answersoft-lm	1781
hp-hcip	1782
fjris	1783
finle-lm	1784
windlm	1785
funk-logger	1786
funk-license	1787
psmond	1788
hello	1789
nmsp	1790
ea1	1791
ibm-dt-2	1792
rsc-robot	1793
cera-bcm	1794
dpi-proxy	1795
vocaltec-admin	1796
uma	1797
etp	1798
netrisk	1799
ansys-lm	1800
msmq	1801
concomp1	1802
hp-hcip-gwy	1803
enl	1804
enl-name	1805
musiconline	1806
fhsp	1807
oracle-vp2	1808
oracle-vp1	1809
jerand-lm	1810
scientia-sdb	1811
radius	1812
radius-acct	1813
tdp-suite	1814
mmpft	1815
etftp	1818
plato-lm	1819
mcagent	1820
donnyworld	1821
es-elmd	1822
unisys-lm	1823
metrics-pas	1824
fjicl-tep-a	1901
fjicl-tep-b	1902
linkname	1903
fjicl-tep-c	1904
sugp	1905
tpmd	1906
tportmapperreq	1906
intrastar	1907
dawn	1908
global-wlink	1909
mtp	1911
armadp	1913
elm-momentum	1914
facelink	1915
persoft	1916
noagent	1917
can-nds	1918
can-dch	1919
can-ferret	1920
close-combat	1944
dialogic-elmd	1945
tekpls	1946
eye2eye	1948
ismaeasdaqlive	1949
ismaeasdaqtest	1950
bcs-lmserver	1951
dlsrap	1973
foliocorp	1985
licensedaemon	1986
tr-rsrb-p1	1987
tr-rsrb-p2	1988
mshnet	1989
tr-rsrb-p3	1989
stun-p1	1990
stun-p2	1991
ipsendmsg	1992
stun-p3	1992
snmp-tcp-port	1993
stun-port	1994
perf-port	1995
tr-rsrb-port	1996
gdp-port	1997
x25-svc-port	1998
tcp-id-port	1999
callbook	2000
dc	2001
globe	2002
mailbox	2004
berknet	2005
invokator	2006
dectalk	2007
conf	2008
search	2010
raid-cc	2011
ttyinfo	2012
raid-am	2013
troff	2014
cypress	2015
bootserver	2016
cypress-stat	2017
terminaldb	2018
whosockami	2019
xinupageserver	2020
servexec	2021
down	2022
xinuexpansion3	2023
xinuexpansion4	2024
ellpack	2025
scrabble	2026
shadowserver	2027
submitserver	2028
device2	2030
blackboard	2032
glogger	2033
scoremgr	2034
imsldoc	2035
objectmanager	2038
lam	2040
interbase	2041
isis	2042
isis-bcast	2043
rimsl	2044
cdfunc	2045
sdfunc	2046
dls	2047
dls-monitor	2048
nfs	2049
shilp	2049
dlsrpn	2065
dlswpn	2067
zephyr-srv	2102
zephyr-clt	2103
zephyr-hm	2104
minipay	2105
mc-gt-srv	2180
ats	2201
imtc-map	2202
kali	2213
unreg-ab1	2221
unreg-ab2	2222
inreg-ab3	2223
ivs-video	2232
infocrypt	2233
directplay	2234
sercomm-wlink	2235
nani	2236
optech-port1-lm	2237
aviva-sna	2238
imagequery	2239
ivsd	2241
xmquery	2279
lnvpoller	2280
lnvconsole	2281
lnvalarm	2282
lnvstatus	2283
lnvmaps	2284
lnvmailmon	2285
nas-metering	2286
dna	2287
netml	2288
pehelp	2307
sdhelp	2308
cvspserver	2401
rtsserv	2500
rtsclient	2501
hp-3000-telnet	2564
netrek	2592
tqdata	2700
www-dev	2784
aic-np	2785
aic-oncrpc	2786
piccolo	2787
fryeserv	2788
media-agent	2789
mao	2908
funk-dialout	2909
tdaccess	2910
blockade	2911
epicon	2912
hbci	3000
redwood-broker	3001
exlm-agent	3002
gw	3010
trusted-web	3011
hlserver	3047
pctrader	3048
nsws	3049
vmodem	3141
rdc-wh-eos	3142
seaview	3143
tarantella	3144
csi-lfap	3145
mc-brk-srv	3180
ccmail	3264
altav-tunnel	3265
ns-cfg-server	3266
ibm-dial-out	3267
msft-gc	3268
msft-gc-ssl	3269
verismart	3270
csoft-prev	3271
user-manager	3272
sxmp	3273
ordinox-server	3274
samd	3275
maxim-asics	3276
dec-notes	3333
bmap	3421
mira	3454
prsvp	3455
vat	3456
vat-control	3457
d3winosfi	3458
integral	3459
mapper-nodemgr	3984
mapper-mapethd	3985
mapper-ws_ethd	3986
terabase	4000
netcheque	4008
chimera-hwm	4009
samsung-unidex	4010
altserviceboot	4011
pda-gate	4012
acl-manager	4013
nuts_dem	4132
nuts_bootp	4133
nifty-hmi	4134
oirtgsvc	4141
oidocsvc	4142
oidsr	4143
rwhois	4321
unicall	4343
vinainstall	4344
krb524	4444
nv-video	4444
upnotifyp	4445
n1-fwp	4446
n1-rmgmt	4447
asc-slmd	4448
arcryptoip	4449
camp	4450
ctisystemmsg	4451
ctiprogramload	4452
nssalertmgr	4453
nssagentmgr	4454
sae-urn	4500
urn-x-cdchoice	4501
hylafax	4559
rfa	4672
commplex-main	5000
commplex-link	5001
rfe	5002
claris-fmpro	5003
avt-profile-1	5004
avt-profile-2	5005
telelpathstart	5010
telepathstart	5010
telelpathattack	5011
telepathattack	5011
zenginkyo-1	5020
zenginkyo-2	5021
mmcc	5050
rmonitor_secure	5145
atmp	5150
america-online	5190
aol	5190
americaonline1	5191
aol-1	5191
americaonline2	5192
aol-2	5192
americaonline3	5193
aol-3	5193
padl2sim	5236
hacl-hb	5300
hacl-gs	5301
hacl-cfg	5302
hacl-probe	5303
hacl-local	5304
hacl-test	5305
sun-mc-grp	5306
sco-aip	5307
cfengine	5308
jprinter	5309
outlaws	5310
tmlogin	5311
excerpt	5400
excerpts	5401
mftp	5402
hpoms-ci-lstn	5403
hpoms-dps-lstn	5404
netsupport	5405
systemics-sox	5406
foresyte-clear	5407
foresyte-sec	5408
salient-dtasrv	5409
salient-usrmgr	5410
actnet	5411
continuus	5412
wwiotalk	5413
statusd	5414
ns-server	5415
sns-gateway	5416
sns-agent	5417
mcntp	5418
dj-ice	5419
cylink-c	5420
personal-agent	5555
esmmanager	5600
esmagent	5601
a1-msc	5602
a1-bs	5603
a3-sdunode	5604
a4-sdunode	5605
pcanywheredata	5631
pcanywherestat	5632
rrac	5678
dccm	5679
proshareaudio	5713
prosharevideo	5714
prosharedata	5715
prosharerequest	5716
prosharenotify	5717
openmail	5729
fcopy-server	5745
openmailg	5755
x500ms	5757
openmailns	5766
s-openmail	5767
x11	6000
softcm	6110
spc	6111
dtspcd	6112
backup-express	6123
meta-corp	6141
aspentec-lm	6142
watershed-lm	6143
statsci1-lm	6144
statsci2-lm	6145
lonewolf-lm	6146
montage-lm	6147
tal-pod	6149
crip	6253
clariion-evr01	6389
skip-cert-recv	6455
skip-cert-send	6456
lvision-lm	6471
xdsxdm	6558
vocaltec-gold	6670
vision_server	6672
vision_elmd	6673
ambit-lm	6831
acmsoda	6969
afs3-fileserver	7000
afs3-callback	7001
afs3-prserver	7002
afs3-vlserver	7003
afs3-kaserver	7004
afs3-volser	7005
afs3-errors	7006
afs3-bos	7007
afs3-update	7008
afs3-rmtsys	7009
ups-onlinet	7010
lazy-ptop	7099
font-service	7100
virprot-lm	7121
clutild	7174
fodms	7200
dlip	7201
winqedit	7395
pmdmgr	7426
oveadmgr	7427
ovladmgr	7428
opi-sock	7429
xmpv7	7430
pmd	7431
telops-lmd	7491
pafec-lm	7511
cbt	7777
accu-lmgr	7781
quest-vista	7980
irdmi2	7999
irdmi	8000
pro-ed	8032
npmp	8450
ddi-tcp-1	8888
ddi-tcp-2	8889
ddi-tcp-3	8890
ddi-tcp-4	8891
ddi-tcp-5	8892
ddi-tcp-6	8893
ddi-tcp-7	8894
cslistener	9000
man	9535
sd	9876
distinct32	9998
distinct	9999
ndmp	10000
tsaf	12753
dsmcc-config	13818
dsmcc-session	13819
dsmcc-passthru	13820
dsmcc-download	13821
dsmcc-ccp	13822
isode-dua	17007
biimenu	18000
webphone	21845
netspeak-is	21846
netspeak-cs	21847
netspeak-acd	21848
netspeak-cps	21849
wnn6	22273
vocaltec-wconf	22555
aws-brf	22800
brf-gw	22951
icl-twobase1	25000
icl-twobase2	25001
icl-twobase3	25002
icl-twobase4	25003
icl-twobase5	25004
icl-twobase6	25005
icl-twobase7	25006
icl-twobase8	25007
icl-twobase9	25008
icl-twobase10	25009
vocaltec-hos	25793
quake	26000
wnn6-ds	26208
dbbrowse	47557
alc	47806
ap	47806
bacnet	47808
";

#& _ianaport($servname,\%ports,\$ports) : {$portnum | undef}
sub _ianaport ($\%\$)
{
    my ($svc,$defports,$rstr) = @_;
    unless (%$defports) {
	%$defports = split(' ', $$rstr);
	# now have to force a real free() and not just SvPOK_off()
	$$rstr = $defports;	# convert SVt_PV to SVt_RV to free the string
	undef $$rstr;
    }
    $defports->{$svc};
}

#& _setport($self,$key,$newval) : {'' | "carp string"}
sub _setport
{
    my($self,$key,$newval) = @_;
    return "Invalid arguments to " . __PACKAGE__ . "::_setport(@_), called"
	if @_ != 3 || !exists($ {*$self}{Keys}{$key});
    my $whoami = $self->_trace(\@_,1);
    my($skey,$hkey,$pkey,$svc,$port,$proto,$type,$host,$reval);
    my($pname,$defport,@serv);
    ($skey = $key) =~ s/port$/service/;	# a key known to be for a service
    ($pkey = $key) =~ s/service$/port/;	# and one for the port
    ($hkey = $pkey) =~ s/port$/host/; # another for calling _sethost
    if (!defined $newval) {	# deleting a service or port
	delete $ {*$self}{Parms}{$skey};
	delete $ {*$self}{Parms}{$pkey} unless $self->isconnected;
	my @delkeys;
	if ($pkey eq 'thisport') {
	    @delkeys = qw(srcaddrlist srcaddr);
	}
	elsif ($pkey eq 'destport') {
	    @delkeys = qw(dstaddrlist dstaddr);
	}
	pop(@delkeys) if @delkeys and $self->isconnected;
	$self->delparams(\@delkeys) if @delkeys;
	return '';		# ok to delete
    }
    # here, we're trying to set a port or service
    $pname = $self->getparam('IPproto');
    $proto = $self->getparam('proto'); # try to find our protocol
    if (!defined($pname) && !$proto
	&& defined($type = $self->getparam('type'))) {
	# try to infer protocol from SO_TYPE
	if ($type == SOCK_STREAM) {
	    $proto = IPPROTO_TCP();
	}
	elsif ($type == SOCK_DGRAM) {
	    $proto = IPPROTO_UDP();
	}
    }
    if (defined $proto and not defined $pname) {
	$pname = getprotobynumber($proto);
	unless (defined $pname) {
	    if ($proto == IPPROTO_UDP()) {
		$pname = 'udp';
	    }
	    elsif ($proto == IPPROTO_TCP()) {
		$pname = 'tcp';
	    }
	    elsif ($proto == IPPROTO_ICMP()) {
		$pname = 'icmp';
	    }
	}
    }

    $reval = $newval;		# make resetting $_[2] simple
    $svc = $ {*$self}{Parms}{$skey}; # preserve earlier values
    $port = $ {*$self}{Parms}{$pkey};
    $port = undef if
	defined($port) and $port =~ /\D/; # but stored ports must be numeric
    ($newval,$defport) = ($1,$2+0)
	if  $newval =~ /^(.+)\((\d+)\)$/;
    if ($skey eq $key || $newval =~ /\D/) { # trying to set a service
	@serv = getservbyname($newval,$pname); # try to find the port info
    }
    if ($newval !~ /\D/ && !@serv) { # setting a port number (even if service)
	$port = $newval+0;	# just in case no servent is found
	@serv = getservbyport(htons($port),$pname) if $pname;
    }
    if (@serv) {		# if we resolved name/number input
	$svc = $serv[0];	# save the canonical service name (and number?)
	$port = 0+$serv[2] unless $key eq $pkey and $newval !~ /\D/;
    }
    elsif (!$defport && $newval =~ /\D/) { # unknown service
	if ($pname eq 'udp') {
	    $defport = _ianaport("\L$newval",%udp_ports,$udp_ports);
	}
	elsif ($pname eq 'tcp') {
	    $defport = _ianaport("\L$newval",%tcp_ports,$tcp_ports);
	}
	return "Unknown service $newval, found" unless $defport;
	$port = $defport+0;
	$svc = $newval;
    }
    elsif ($defport && $newval) {
	$svc = $newval;
	$port = $defport;
    }
    elsif ($key eq $skey or $newval =~ /\D/) { # setting unknown service
	return "Unknown service $newval, found";
    }
    $reval = (($key eq $skey) ? $svc : $port); # in case we get that far
    $ {*$self}{Parms}{$skey} = $svc if $svc; # in case no port change
    $_[2] = $reval;
    print STDERR " - " . __PACKAGE__ . "::_setport $self $skey $svc\n" if
	$svc and $self->debug;
    print STDERR " - " . __PACKAGE__ . "::_setport $self $pkey $port\n" if
	defined $port and $self->debug;
# Have to keep going here for implicit bind() from init().
#    return '' if defined($ {*$self}{Parms}{$pkey}) and
#	$ {*$self}{Parms}{$pkey} == $port; # not an update if same number
    $ {*$self}{Parms}{$pkey} = $port; # in case was service key
    # check for whether we can ask _sethost to set {dst,src}addrlist now
    return '' unless
	defined($host = $ {*$self}{Parms}{$hkey}) or $hkey eq 'thishost';
    $host = '0' if !defined $host; # 'thishost' value was null
    $self->setparams({$hkey => $host},0,1); # try it
    '';				# return goodness from here
}

#& _setproto($this, $key, $newval) : {'' | "carp string"}
sub _setproto
{
    my($self,$key,$newval) = @_;
    if (!defined $newval) {	# delparams call?
	# make both go away at once
	delete @{ $ {*$self}{Parms} }{'IPproto','proto'};
	return '';
    }
    my($pname,$proto);
    if ($key ne 'proto' or $newval =~ /\D/) { # have to try for name->number
	my @pval = getprotobyname($newval);
	if (@pval) {
	    $pname = $pval[0];
	    $proto = $pval[2];
	}
    }
    if (!defined($proto) and $newval !~ /\D/) { # numeric proto, find name
	$proto = $newval+0;
	$pname = getprotobynumber($proto);
    }
    return "Unknown protocol ($newval), seen"
	unless defined $proto;
    unless (defined $pname) {
	if ($proto == IPPROTO_UDP) {
	    $pname = 'udp';
	}
	elsif ($proto == IPPROTO_TCP) {
	    $pname = 'tcp';
	}
	elsif ($proto == IPPROTO_ICMP) {
	    $pname = 'icmp';
	}
    }
    $ {*$self}{Parms}{IPproto} = $pname; # update our values
    $ {*$self}{Parms}{proto} = $proto;
    # make sure the right value gets set
    $_[2] = (($key eq 'proto') ? $proto : $pname);
    '';				# return goodness
}

#& _addrinfo($this, $sockaddr) : (name, addr, service, portnum)
sub _addrinfo
{
    my($this,$sockaddr) = @_;
    my($fam,$port,$serv,$name,$addr,@hinfo);
    ($fam,$port,$addr) = unpack_sockaddr_in($sockaddr);
    @hinfo = gethostbyaddr($addr,$fam);
    $addr = inet_ntoa($addr);
    $name = (!@hinfo) ? $addr : $hinfo[0];
    $serv = getservbyport(htons($port),
			  (ref $this) && $this->getparam('IPproto')) || $port;
    ($name, $addr, $serv, $port);
}

#& getsockinfo($this) : $remote_addr || ($local_addr, $rem_addr) | ()
sub getsockinfo : locked method
{
    my($self) = @_;
    my($rem,$lcl,$port,$serv,$name,$addr);
    ($lcl,$rem) = $self->SUPER::getsockinfo;
    if (defined $rem and length($rem)) {
	($name, $addr, $serv, $port) = $self->_addrinfo($rem);
	$self->setparams({remhost => $name, remaddr => $addr,
			  remservice => $serv, remport => $port});
    }
    if (defined $lcl and length($lcl)) {
	($name, $addr, $serv, $port) = $self->_addrinfo($lcl);
	$self->setparams({lclhost => $name, lcladdr => $addr,
			  lclservice => $serv, lclport => $port});
    }
    wantarray ? ((defined $lcl || defined $rem) ? ($lcl,$rem) : ())
	: $rem;
}

#& format_addr($this, $sockaddr, [numeric_only]) : $string
sub format_addr
{
    my($this,$sockaddr,$numeric) = @_;
    my($name,$addr,$serv,$port) = $this->_addrinfo($sockaddr);
    if ($numeric) {
	"${addr}:${port}";
    }
    else {
	"${name}:${serv}";
    }
}


1;

# autoloaded methods go after the END token (& pod) below

__END__

=head1 NAME

Net::Inet - Internet socket interface module

=head1 SYNOPSIS

    use Net::Gen;		# optional
    use Net::Inet;

=head1 DESCRIPTION

The C<Net::Inet> module provides basic services for handling
socket-based communications for the Internet protocol family.  It
inherits from
L<C<Net::Gen>|Net::Gen>,
and is a base for
L<C<Net::TCP>|Net::TCP>
and
L<C<Net::UDP>|Net::UDP>.

=head2 Public Methods

=over 4

=item new

Usage:

    $obj = new Net::Inet;
    $obj = new Net::Inet $desthost, $destservice;
    $obj = new Net::Inet \%parameters;
    $obj = new Net::Inet $desthost, $destservice, \%parameters;
    $obj = 'Net::Inet'->new();
    $obj = 'Net::Inet'->new($desthost, $destservice);
    $obj = 'Net::Inet'->new(\%parameters);
    $obj = 'Net::Inet'->new($desthost, $destservice, \%parameters);

Returns a newly-initialised object of the given class.  If called
for a derived class, no validation of the supplied parameters
will be performed.  (This is so that the derived class can set up
the parameter validation it needs in the object before allowing
the validation.)  Otherwise, it will cause the parameters to be
validated by calling its C<init> method.  In particular, this
means that if both a host and a service are given, then an object
will only be returned if a connect() call was successful, or if
the object is non-blocking and a connect() call is in progress.

The examples above show the indirect object syntax which many prefer,
as well as the guaranteed-to-be-safe static method call.  There
are occasional problems with the indirect object syntax, which
tend to be rather obscure when encountered.  See
http://www.xray.mpe.mpg.de/mailing-lists/perl-porters/1998-01/msg01674.html
for details.

=item init

Usage:

    return undef unless $self->init;
    return undef unless $self->init(\%parameters);
    return undef unless $self->init($desthost, $destservice);
    return undef unless $self->init($desthost, $destservice, \%parameters);

Verifies that all previous parameter assignments are valid (via
C<checkparams>).  Returns the incoming object on success, and
C<undef> on failure.  Usually called only via a derived class's
C<init> method or its own C<new> call.

=item bind

Usage:

    $ok = $obj->bind;
    $ok = $obj->bind($lclhost, $lclservice);
    $ok = $obj->bind($lclhost, $lclservice, \%parameters);

Sets up the C<srcaddrlist> object parameter with the specified
$lclhost and $lclservice arguments if supplied (via the C<thishost> and
C<thisport> object parameters), and then returns the value from
the inherited C<bind> method.  Changing of parameters is also
allowed, mainly for setting debug status or timeouts.

Example:

    $ok = $obj->bind(0, 'echo(7)'); # attach to the local TCP echo port

=item unbind

Usage:

    $obj->unbind;

Deletes the C<thishost> and C<thisport> object parameters, and
then (assuming that succeeds, which it should) returns the value
from the inherited C<unbind> method.

=item connect

Usage:

    $ok = $obj->connect;
    $ok = $obj->connect($host, $service);
    $ok = $obj->connect($host, $service, \%parameters);

Attempts to establish a connection for the object.  If the $host
or $service arguments are specified, they will be used to set the
C<desthost> and C<destservice>/C<destport> object parameters,
with side-effects of setting up the C<dstaddrlist> object
parameter.  Then, the result of a call to the inherited
C<connect> method will be returned.  Changing of parameters is
also allowed, mainly for setting debug status or timeouts.

=item format_addr

Usage:

    $string = $obj->format_addr($sockaddr);
    $string = $obj->format_addr($sockaddr, $numeric_only);
    $string = format_addr Module $sockaddr;
    $string = format_addr Module $sockaddr, $numeric_only;

Returns a formatted representation of the address.  This is a
method so that it can be overridden by derived classes.  It is
used to implement ``pretty-printing'' methods for source and
destination addresses.  If the $numeric_only argument is true,
the address and port number will be used even if they can be
resolved to names.  Otherwise, the resolved hostname and service
name will be used if possible.

=item format_local_addr

Usage:

    $string = $obj->format_local_addr;
    $string = $obj->format_local_addr($numeric_only);

Returns a formatted representation of the local socket address
associated with the object.  A sugar-coated way of calling the
C<format_addr> method for the C<srcaddr> object parameter.

=item format_remote_addr

Usage:

    $string = $obj->format_remote_addr;

Returns a formatted representation of the remote socket address
associated with the object.  A sugar-coated way of calling the
C<format_addr> method for the C<dstaddr> object parameter.

=item getsockinfo

An augmented form of
L<C<Net::Gen::getsockinfo>|Net::Gen/getsockinfo>.  Aside from
updating more object parameters, it behaves the same as that in
the base class.  The additional object parameters which get set
are C<lcladdr>, C<lclhost>, C<lclport>, C<lclservice>,
C<remaddr>, C<remhost>, C<remport>, and C<remservice>.  (They are
described in L<"Known Object Parameters"> below.)

=back

There are also various I<accessor> methods for the object parameters.
See L<Net::Gen/"Public Methods"> (where it talks about C<Accessors>)
for calling details.
See L<"Known Object Parameters"> below
for those defined by this class.

=head2 Protected Methods

[See the note in L<Net::Gen/"Protected Methods"> about my
definition of protected methods in Perl.]

None.

=head2 Known Socket Options

These are the socket options known to the C<Net::Inet> module
itself:

=over 4

=item Z<>

C<IP_HDRINCL> C<IP_RECVDSTADDR> C<IP_RECVOPTS> C<IP_RECVRETOPTS>
C<IP_TOS> C<IP_TTL> C<IP_ADD_MEMBERSHIP> C<IP_DROP_MEMBERSHIP>
C<IP_MULTICAST_IF> C<IP_MULTICAST_LOOP> C<IP_MULTICAST_TTL>
C<IP_OPTIONS> C<IP_RETOPTS>

=back

=head2 Known Object Parameters

These are the object parameters registered by the C<Net::Inet>
module itself:

=over 4

=item IPproto

The name of the Internet protocol in use on the socket associated
with the object.  Set as a side-effect of setting the C<proto>
object parameter, and vice versa.

=item proto

Used the same way as with L<C<Net::Gen>|Net::Gen/proto>,
but has a handler attached
to keep it in sync with C<IPproto>.

=item thishost

The source host name or address to use for the C<bind> method.
When used in conjunction with the C<thisservice> or C<thisport>
object parameter, causes the C<srcaddrlist> object parameter to
be set, which is how it affects the bind() action.  This
parameter is validated, and must be either a valid internet
address or a hostname for which an address can be found.  If a
hostname is given, and multiple addresses are found for it, then
each address will be entered into the C<srcaddrlist> array
reference.

=item desthost

The destination host name or address to use for the C<connect>
method.  When used in conjunction with the C<destservice> or
C<destport> object parameter, causes the C<dstaddrlist> object
parameter to be set, which is how it affects the connect()
action.  This parameter is validated, and must be either a valid
internet address or a hostname for which an address can be found.
If a hostname is given, and multiple addresses are found for it,
then each address will be entered into the C<dstaddrlist> array
reference, in order.  This allows the C<connect> method to
attempt a connection to each address, as per RFC 1123.

=item thisservice

The source service name (or number) to use for the C<bind>
method.  An attempt will be made to translate the supplied
service name with getservbyname().  If that succeeds, or if it
fails but the supplied value was strictly numeric, the port
number will be set in the C<thisport> object parameter.  If the
supplied value is not numeric and can't be translated, the
attempt to set the value will fail.  Otherwise, this causes the
C<srcaddrlist> object parameter to be updated, in preparation for
an invocation of the C<bind> method (possibly implicitly from the
C<connect> method).

=item thisport

The source service number (or name) to use for the C<bind>
method.  An attempt will be made to translate the supplied
service name with getservbyname() if it is not strictly numeric.
If that succeeds, the given name will be set in the
C<thisservice> parameter, and the resolved port number will be
set in the C<thisport> object parameter.  If the supplied value
is strictly numeric, and a call to getservbyport can resolve a
name for the service, the C<thisservice> parameter will be
updated appropriately.  If the supplied value is not numeric and
can't be translated, the attempt to set the value will fail.
Otherwise, this causes the C<srcaddrlist> object parameter to be
updated, in preparation for an invocation of the C<bind> method
(possibly implicitly from the C<connect> method).

=item destservice

The destination service name (or number) to use for the
C<connect> method.  An attempt will be made to translate the
supplied service name with getservbyname().  If that succeeds, or
if it fails but the supplied value was strictly numeric, the port
number will be set in the C<destport> object parameter.  If the
supplied value is not numeric and can't be translated, the
attempt to set the value will fail.  Otherwise, if the
C<desthost> parameter has a defined value, this causes the
C<dstaddrlist> object parameter to be updated, in preparation for
an invocation of the C<connect> method.

=item destport

The destination service number (or name) to use for the
C<connect> method.  An attempt will be made to translate the
supplied service name with getservbyname() if it is not strictly
numeric.  If that succeeds, the given name will be set in the
C<destservice> parameter, and the resolved port number will be
set in the C<destport> parameter.  If the supplied value is
strictly numeric, and a call to getservbyport can resolve a name
for the service, the C<destservice> parameter will be updated
appropriately.  If the supplied value is not numeric and can't be
translated, the attempt to set the value will fail.  Otherwise,
if the C<desthost> parameter has a defined value, this causes the
C<dstaddrlist> object parameter to be updated, in preparation for
an invocation of the C<connect> method.

=item lcladdr

The local IP address stashed by the C<getsockinfo> method after a
successful bind() or connect() call.

=item lclhost

The local hostname stashed by the C<getsockinfo> method after a
successful bind() or connect(), as resolved from the C<lcladdr>
object parameter.

=item lclport

The local port number stashed by the C<getsockinfo> method after a
successful bind() or connect() call.

=item lclservice

The local service name stashed by the C<getsockinfo> method after
a successful bind() or connect(), as resolved from the C<lclport>
object parameter.

=item remaddr

The remote IP address stashed by the C<getsockinfo> method after a
successful connect() call.

=item remhost

The remote hostname stashed by the C<getsockinfo> method after a
successful connect() call, as resolved from the C<remaddr>
object parameter.

=item remport

The remote port number stashed by the C<getsockinfo> method after a
successful connect() call.

=item remservice

The remote service name stashed by the C<getsockinfo> method after
a successful connect() call, as resolved from the C<remport>
object parameter.

=back

=head2 Non-Method Subroutines

=over 4

=item inet_aton

Usage:

    $in_addr = inet_aton('192.0.2.1');

Returns the packed C<AF_INET> address in network order, if it is
validly formed, or C<undef> on error.  This used to be a separate
implementation in this package, but is now inherited from the
C<Socket> module.

=item inet_addr

A synonym for inet_aton() (for old fogeys like me who forget
about the new name).  (Yes, I know it's different in C, but in
Perl there's no need to propagate the old inet_addr()
braindamage of being unable to handle "255.255.255.255", so I didn't.)

=item inet_ntoa

Usage:

    $addr_string = inet_ntoa($in_addr);

Returns the ASCII representation of the C<AF_INET> address
provided (if possible), or C<undef> on error.  This used to be a
separate implementation in this package, but is now inherited
from the C<Socket> module.

=item htonl

=item htons

=item ntohl

=item ntohs

About as those who are used to them might expect, I think.
However, these versions will return lists in list context, and will
complain if given a multi-element list in scalar context.

[For those who don't know what these are, and who don't have documentation
on them in their existing system documentation, these functions convert data
between 'host' and 'network' byte ordering, for 'short' or 'long' network
data.  (This should explain the 'h', 'n', 's', and 'l' letters in the
names.)  Long network data means 32-bit quantities, such as IP addresses, and
short network data means 16-bit quantities, such as IP port numbers.
You'd only need to use these functions if you're not using the methods from
this package to build your packed 'sockaddr' structures or to unpack their
data after a connect() or accept().]


=item pack_sockaddr_in

Usage:

    $connect_address = pack_sockaddr_in($family, $port, $in_addr);
    $connect_address = pack_sockaddr_in($port, $in_addr);

Returns the packed C<struct sockaddr_in> corresponding to the
provided $family, $port, and $in_addr arguments.  The $family and
$port arguments must be numbers, and the $in_addr argument must
be a packed C<struct in_addr> such as the trailing elements from
perl's gethostent() return list.  This differs from the
implementation in the C<Socket> module in that the C<$family>
argument is available (though optional).  The C<$family> argument
defaults to C<AF_INET>.

=item unpack_sockaddr_in

Usage:

    ($family, $port, $in_addr) = unpack_sockaddr_in($connected_address);

Returns the address family, port, and packed C<struct in_addr>
from the supplied packed C<struct sockaddr_in>.  This is the
inverse of pack_sockaddr_in().  This differs from the
implementation in the C<Socket> module in that the C<$family>
value from the socket address is returned (and might not be C<AF_INET>).

=item INADDR_UNSPEC_GROUP

=item INADDR_ALLHOSTS_GROUP

=item INADDR_ALLRTRS_GROUP

=item INADDR_MAX_LOCAL_GROUP

Constant routines returning the S<unspecified local>, S<all hosts>,
S<all routers>, or the maximum possible local IP multicast group
address, respectively.  These routines return results in the form
of a packed C<struct inaddr> much like the C<INADDR_ANY> result
described in L<Socket/INADDR_ANY>.

=item IN_CLASSA

=item IN_CLASSB

=item IN_CLASSC

=item IN_CLASSD

=item IN_MULTICAST

=item IN_EXPERIMENTAL

=item IN_BADCLASS

Usage:

    $boolean = IN_EXPERIMENTAL(INADDR_ALLHOSTS_GROUP);
    $boolean = IN_CLASSA(0x7f000001);

These routines return the I<network class> information for the
supplied IP address.  Of these, only IN_BADCLASS() and
IN_MULTICAST() are really useful in today's Internet, since the
advent of CIDR (classless Internet domain routing).  In
particular, IN_EXPERIMENTAL() is at the mercy of your vendor's
definition.  The first example above will be true only on older
systems, which almost certainly don't support IP multicast
anyway.  The argument to any of these functions can be either a
packed C<struct inaddr> such as that returned by inet_ntoa() or
unpack_sockaddr_in(), or an integer (or integer expression)
giving an IP address in I<host> byte order.

=item IPOPT_CLASS

=item IPOPT_COPIED

=item IPOPT_NUMBER

Usage:

    $optnum = IPOPT_NUMBER($option);

These routines extract information from IP option numbers, as per
the information on IP options in RFC 791.

=item ...

Other constants which relate to parts of IP or ICMP headers or
vendor-defined socket options, as listed in L<"Exports"> below.

=back

=head2 Exports

=over 4

=item default

C<INADDR_ALLHOSTS_GROUP> C<INADDR_ALLRTRS_GROUP> C<INADDR_ANY>
C<INADDR_BROADCAST> C<INADDR_LOOPBACK> C<INADDR_MAX_LOCAL_GROUP>
C<INADDR_NONE> C<INADDR_UNSPEC_GROUP> C<IPPORT_RESERVED>
C<IPPORT_USERRESERVED>
C<IPPORT_DYNAMIC>
C<IPPROTO_EGP> C<IPPROTO_EON> C<IPPROTO_GGP>
C<IPPROTO_HELLO> C<IPPROTO_ICMP> C<IPPROTO_IDP> C<IPPROTO_IGMP>
C<IPPROTO_IP> C<IPPROTO_IPIP> C<IPPROTO_MAX> C<IPPROTO_PUP>
C<IPPROTO_RAW> C<IPPROTO_RSVP> C<IPPROTO_TCP> C<IPPROTO_TP>
C<IPPROTO_UDP> C<htonl> C<htons> C<inet_addr> C<inet_aton> C<inet_ntoa>
C<ntohl> C<ntohs>

=item exportable

C<DEFTTL> C<ICMP_ADVLENMIN> C<ICMP_ECHO> C<ICMP_ECHOREPLY>
C<ICMP_INFOTYPE> C<ICMP_IREQ> C<ICMP_IREQREPLY> C<ICMP_MASKLEN>
C<ICMP_MASKREPLY> C<ICMP_MASKREQ> C<ICMP_MAXTYPE> C<ICMP_MINLEN>
C<ICMP_PARAMPROB> C<ICMP_REDIRECT> C<ICMP_REDIRECT_HOST>
C<ICMP_REDIRECT_NET> C<ICMP_REDIRECT_TOSHOST> C<ICMP_REDIRECT_TOSNET>
C<ICMP_SOURCEQUENCH> C<ICMP_TIMXCEED> C<ICMP_TIMXCEED_INTRANS>
C<ICMP_TIMXCEED_REASS> C<ICMP_TSLEN> C<ICMP_TSTAMP> C<ICMP_TSTAMPREPLY>
C<ICMP_UNREACH> C<ICMP_UNREACH_HOST> C<ICMP_UNREACH_NEEDFRAG>
C<ICMP_UNREACH_NET> C<ICMP_UNREACH_PORT> C<ICMP_UNREACH_PROTOCOL>
C<ICMP_UNREACH_SRCFAIL> C<IN_BADCLASS> C<IN_CLASSA> C<IN_CLASSA_HOST>
C<IN_CLASSA_MAX> C<IN_CLASSA_NET> C<IN_CLASSA_NSHIFT>
C<IN_CLASSA_SUBHOST> C<IN_CLASSA_SUBNET> C<IN_CLASSA_SUBNSHIFT>
C<IN_CLASSB> C<IN_CLASSB_HOST> C<IN_CLASSB_MAX> C<IN_CLASSB_NET>
C<IN_CLASSB_NSHIFT> C<IN_CLASSB_SUBHOST> C<IN_CLASSB_SUBNET>
C<IN_CLASSB_SUBNSHIFT> C<IN_CLASSC> C<IN_CLASSC_HOST> C<IN_CLASSC_MAX>
C<IN_CLASSC_NET> C<IN_CLASSC_NSHIFT> C<IN_CLASSD> C<IN_CLASSD_HOST>
C<IN_CLASSD_NET> C<IN_CLASSD_NSHIFT> C<IN_EXPERIMENTAL>
C<IN_LOOPBACKNET> C<IN_MULTICAST> C<IPFRAGTTL> C<IPOPT_CIPSO>
C<IPOPT_CLASS> C<IPOPT_CONTROL> C<IPOPT_COPIED> C<IPOPT_DEBMEAS>
C<IPOPT_EOL> C<IPOPT_LSRR> C<IPOPT_MINOFF> C<IPOPT_NOP> C<IPOPT_NUMBER>
C<IPOPT_OFFSET> C<IPOPT_OLEN> C<IPOPT_OPTVAL> C<IPOPT_RESERVED1>
C<IPOPT_RESERVED2> C<IPOPT_RIPSO_AUX> C<IPOPT_RR> C<IPOPT_SATID>
C<IPOPT_SECURITY> C<IPOPT_SECUR_CONFID> C<IPOPT_SECUR_EFTO>
C<IPOPT_SECUR_MMMM> C<IPOPT_SECUR_RESTR> C<IPOPT_SECUR_SECRET>
C<IPOPT_SECUR_TOPSECRET> C<IPOPT_SECUR_UNCLASS> C<IPOPT_SSRR>
C<IPOPT_TS> C<IPOPT_TS_PRESPEC> C<IPOPT_TS_TSANDADDR>
C<IPOPT_TS_TSONLY> C<IPPORT_TIMESERVER> C<IPTOS_LOWDELAY>
C<IPTOS_PREC_CRITIC_ECP> C<IPTOS_PREC_FLASH>
C<IPTOS_PREC_FLASHOVERRIDE> C<IPTOS_PREC_IMMEDIATE>
C<IPTOS_PREC_INTERNETCONTROL> C<IPTOS_PREC_NETCONTROL>
C<IPTOS_PREC_PRIORITY> C<IPTOS_PREC_ROUTINE> C<IPTOS_RELIABILITY>
C<IPTOS_THROUGHPUT> C<IPTTLDEC> C<IPVERSION> C<IP_ADD_MEMBERSHIP>
C<IP_DEFAULT_MULTICAST_LOOP> C<IP_DEFAULT_MULTICAST_TTL> C<IP_DF>
C<IP_DROP_MEMBERSHIP> C<IP_HDRINCL> C<IP_MAXPACKET>
C<IP_MAX_MEMBERSHIPS> C<IP_MF> C<IP_MSS> C<IP_MULTICAST_IF>
C<IP_MULTICAST_LOOP> C<IP_MULTICAST_TTL> C<IP_OPTIONS>
C<IP_RECVDSTADDR> C<IP_RECVOPTS> C<IP_RECVRETOPTS> C<IP_RETOPTS>
C<IP_TOS> C<IP_TTL> C<MAXTTL> C<MAX_IPOPTLEN> C<MINTTL> C<SUBNETSHIFT>
C<pack_sockaddr_in> C<unpack_sockaddr_in>

=item tags

The following :tags are in C<%EXPORT_TAGS>, with the associated exportable
values as listed:

=over 6

=item :sockopts

C<IP_HDRINCL> C<IP_RECVDSTADDR> C<IP_RECVOPTS> C<IP_RECVRETOPTS>
C<IP_TOS> C<IP_TTL> C<IP_ADD_MEMBERSHIP> C<IP_DROP_MEMBERSHIP>
C<IP_MULTICAST_IF> C<IP_MULTICAST_LOOP> C<IP_MULTICAST_TTL>
C<IP_OPTIONS> C<IP_RETOPTS>

=item :routines

C<pack_sockaddr_in> C<unpack_sockaddr_in> C<inet_ntoa> C<inet_aton>
C<inet_addr> C<htonl> C<ntohl> C<htons> C<ntohs> C<ICMP_INFOTYPE>
C<IN_BADCLASS> C<IN_EXPERIMENTAL> C<IN_MULTICAST> C<IPOPT_CLASS>
C<IPOPT_COPIED> C<IPOPT_NUMBER>

=item :icmpvalues

C<ICMP_ADVLENMIN> C<ICMP_ECHO> C<ICMP_ECHOREPLY> C<ICMP_IREQ>
C<ICMP_IREQREPLY> C<ICMP_MASKLEN> C<ICMP_MASKREPLY> C<ICMP_MASKREQ>
C<ICMP_MAXTYPE> C<ICMP_MINLEN> C<ICMP_PARAMPROB> C<ICMP_REDIRECT>
C<ICMP_REDIRECT_HOST> C<ICMP_REDIRECT_NET> C<ICMP_REDIRECT_TOSHOST>
C<ICMP_REDIRECT_TOSNET> C<ICMP_SOURCEQUENCH> C<ICMP_TIMXCEED>
C<ICMP_TIMXCEED_INTRANS> C<ICMP_TIMXCEED_REASS> C<ICMP_TSLEN>
C<ICMP_TSTAMP> C<ICMP_TSTAMPREPLY> C<ICMP_UNREACH> C<ICMP_UNREACH_HOST>
C<ICMP_UNREACH_NEEDFRAG> C<ICMP_UNREACH_NET> C<ICMP_UNREACH_PORT>
C<ICMP_UNREACH_PROTOCOL> C<ICMP_UNREACH_SRCFAIL>

=item :ipoptions

C<IPOPT_CIPSO> C<IPOPT_CONTROL> C<IPOPT_DEBMEAS> C<IPOPT_EOL>
C<IPOPT_LSRR> C<IPOPT_MINOFF> C<IPOPT_NOP> C<IPOPT_OFFSET>
C<IPOPT_OLEN> C<IPOPT_OPTVAL> C<IPOPT_RESERVED1> C<IPOPT_RESERVED2>
C<IPOPT_RIPSO_AUX> C<IPOPT_RR> C<IPOPT_SATID> C<IPOPT_SECURITY>
C<IPOPT_SECUR_CONFID> C<IPOPT_SECUR_EFTO> C<IPOPT_SECUR_MMMM>
C<IPOPT_SECUR_RESTR> C<IPOPT_SECUR_SECRET> C<IPOPT_SECUR_TOPSECRET>
C<IPOPT_SECUR_UNCLASS> C<IPOPT_SSRR> C<IPOPT_TS> C<IPOPT_TS_PRESPEC>
C<IPOPT_TS_TSANDADDR> C<IPOPT_TS_TSONLY> C<MAX_IPOPTLEN>

=item :iptosvalues

C<IPTOS_LOWDELAY> C<IPTOS_PREC_CRITIC_ECP> C<IPTOS_PREC_FLASH>
C<IPTOS_PREC_FLASHOVERRIDE> C<IPTOS_PREC_IMMEDIATE>
C<IPTOS_PREC_INTERNETCONTROL> C<IPTOS_PREC_NETCONTROL>
C<IPTOS_PREC_PRIORITY> C<IPTOS_PREC_ROUTINE> C<IPTOS_RELIABILITY>
C<IPTOS_THROUGHPUT>

=item :protocolvalues

C<DEFTTL> C<INADDR_ALLHOSTS_GROUP> C<INADDR_ALLRTRS_GROUP>
C<INADDR_ANY> C<INADDR_BROADCAST> C<INADDR_LOOPBACK>
C<INADDR_MAX_LOCAL_GROUP> C<INADDR_NONE> C<INADDR_UNSPEC_GROUP>
C<IN_LOOPBACKNET> C<IPPORT_RESERVED>
C<IPPORT_USERRESERVED>
C<IPPORT_DYNAMIC>
C<IPPROTO_EGP> C<IPPROTO_EON> C<IPPROTO_GGP> C<IPPROTO_HELLO>
C<IPPROTO_ICMP> C<IPPROTO_IDP> C<IPPROTO_IGMP> C<IPPROTO_IP>
C<IPPROTO_IPIP> C<IPPROTO_MAX> C<IPPROTO_PUP> C<IPPROTO_RAW>
C<IPPROTO_RSVP> C<IPPROTO_TCP> C<IPPROTO_TP> C<IPPROTO_UDP>
C<IPFRAGTTL> C<IPTTLDEC> C<IPVERSION> C<IP_DF> C<IP_MAXPACKET> C<IP_MF>
C<IP_MSS> C<MAXTTL> C<MAX_IPOPTLEN> C<MINTTL>

=item :ipmulticast

C<IP_ADD_MEMBERSHIP> C<IP_DEFAULT_MULTICAST_LOOP>
C<IP_DEFAULT_MULTICAST_TTL> C<IP_DROP_MEMBERSHIP> C<IP_MAX_MEMBERSHIPS>
C<IP_MULTICAST_IF> C<IP_MULTICAST_LOOP> C<IP_MULTICAST_TTL>

=item :deprecated

C<IN_CLASSA_HOST> C<IN_CLASSA_MAX> C<IN_CLASSA_NET> C<IN_CLASSA_NSHIFT>
C<IN_CLASSA_SUBHOST> C<IN_CLASSA_SUBNET> C<IN_CLASSA_SUBNSHIFT>
C<IN_CLASSB_HOST> C<IN_CLASSB_MAX> C<IN_CLASSB_NET> C<IN_CLASSB_NSHIFT>
C<IN_CLASSB_SUBHOST> C<IN_CLASSB_SUBNET> C<IN_CLASSB_SUBNSHIFT>
C<IN_CLASSC_HOST> C<IN_CLASSC_MAX> C<IN_CLASSC_NET> C<IN_CLASSC_NSHIFT>
C<IN_CLASSD_HOST> C<IN_CLASSD_NET> C<IN_CLASSD_NSHIFT> C<IN_CLASSA>
C<IN_CLASSB> C<IN_CLASSC> C<IN_CLASSD> C<IPPORT_TIMESERVER>
C<SUBNETSHIFT>

=item :ALL

All of the above exportable items.

=back

Z<>

=back

=head1 NOTES

Anywhere a I<service> or I<port> argument is used above, the
allowed syntax is either a service name, a port number, or a
service name with a caller-supplied default port number.
Examples are C<'echo'>, C<7>, and C<'echo(7)'>, respectively.
For a I<service> argument, a bare port number must be
translatable into a service name with getservbyport() or an error
will result.  A service name must be translatable into a port
with getservbyname() or an error will result.  However, a service
name with a default port number will succeed (by using the
supplied default) even if the translation with getservbyname()
fails.

For example:

    $obj->setparam('destservice', 'http(80)');

This always succeeds, although if your F</etc/services> file (or
equivalent for non-UNIX systems) maps "http" to something other than
port 80, you'll get that other port.

For a contrasting example:

    $obj->setparam('destservice', 80);

This will fail, despite the numeric value, if your F</etc/services> file
(or equivalent) is behind the times and has no mapping to a service name
for port 80.

=head1 THREADING STATUS

This module has been tested with threaded perls, and should be as thread-safe
as perl itself.  (As of 5.005_03 and 5.005_57, that's not all that safe
just yet.)  It also works with interpreter-based threads ('ithreads') in
more recent perl releases.

=head1 SEE ALSO

L<Net::Gen(3)|Net::Gen>,
L<Net::TCP(3)|Net::TCP>,
L<Net::UDP(3)|Net::UDP>

=head1 AUTHOR

Spider Boardman E<lt>spidb@cpan.orgE<gt>

=cut

#other sections should be added, sigh.

#any real autoloaded methods go after this line


#& setdebug($this, [bool, [norecurse]]) : oldvalue
sub setdebug : locked
{
    my $this = shift;
    $this->_debug($_[0]) .
	((@_ > 1 && $_[1]) ? '' : $this->SUPER::setdebug(@_));
}

#& bind($self, [\]@([host],[port])) : boolean
sub bind : locked method
{
    my($self,@args) = @_;
    return undef if @args and not $self->_hostport('this',@args);
    $self->SUPER::bind;
}

#& unbind($self) : boolean
sub unbind : locked method
{
    my($self,@args) = @_;
    if (@args) {
	$whoami = $_[0]->_trace(\@_,0);
	carp "Excess args to ${whoami} ignored";
    }
    $self->delparams([qw(thishost thisport)]) || return undef;
    $self->SUPER::unbind;
}
